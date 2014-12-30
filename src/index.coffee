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

  inflate: (obj) ->
    inflated = {}
    for k, v of obj
      @_inflate(inflated, k, v)
    inflated

  _inflate: (inflated, key, val) ->
    if '.' in key
      parts = key.split('.')
      parent = parts[0]
      child = parts[1..].join('.')
      nested = {}
      nested[parent] = {}

      if '.' in child
        @_inflate(nested[parent], child, val)
      else
        nested[parent][child] = val

      inflated = _.merge(inflated, nested)
    else
      inflated[key] = val
