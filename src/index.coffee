_ = require 'lodash'


module.exports =

  flatten: (obj) ->
    flattened = {}
    for k, v of obj
      @_flatten(flattened, k, v)
    flattened

  _flatten: (flattened, key, val) ->
    if _.isPlainObject(val)
      for k, v of val
        @_flatten(flattened, "#{key}.#{k}", v)
    else
      flattened[key] = val

  expand: (obj) ->
    expanded = {}
    for k, v of obj
      @_expand(expanded, k, v)
    expanded

  _expand: (expanded, key, val) ->
    if '.' in key
      parts = key.split('.')
      parent = parts[0]
      child = parts[1..].join('.')
      nested = {}
      nested[parent] = {}

      if '.' in child
        @_expand(nested[parent], child, val)
      else
        nested[parent][child] = val

      expanded = _.merge(expanded, nested)
    else
      expanded[key] = val
