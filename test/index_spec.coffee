{expect} = require 'chai'

flattenIt = require '../src'


describe 'FlattenIt', ->

  it 'should not alter a non-nested object', ->
    obj =
      one: 1
      two: 2

    flattened = flattenIt.flatten(obj)

    expect(flattened.one).to.equal 1
    expect(flattened.two).to.equal 2

  it 'should flatten a nested object', ->
    obj =
      one: 1
      two: 2
      nested:
        three: 3
        four: 4

    flattened = flattenIt.flatten(obj)

    expect(flattened.one).to.equal 1
    expect(flattened.two).to.equal 2
    expect(flattened['nested.three']).to.equal 3
    expect(flattened['nested.four']).to.equal 4
    expect(flattened.nested).to.not.exist

  it 'should recurse when flattening', ->
    obj =
      one: 1
      two: 2
      nested:
        three: 3
        more:
          four: 4
        crazy:
          scream:
            five: 5

    flattened = flattenIt.flatten(obj)

    expect(flattened.one).to.equal 1
    expect(flattened.two).to.equal 2
    expect(flattened['nested.three']).to.equal 3
    expect(flattened['nested.more.four']).to.equal 4
    expect(flattened['nested.crazy.scream.five']).to.equal 5
    expect(flattened.nested).to.not.exist

  it 'should inflate a flattened object', ->
    obj =
      one: 1
      two: 2
      'nested.three': 3
      'nested.four': 4

    inflated = flattenIt.inflate(obj)

    expect(inflated.one).to.equal 1
    expect(inflated.two).to.equal 2
    expect(inflated.nested.three).to.equal 3
    expect(inflated.nested.four).to.equal 4

  it 'should recurse when inflating', ->
    obj =
      one: 1
      two: 2
      'nested.three': 3
      'nested.more.four': 4
      'nested.crazy.scream.five': 5

    inflated = flattenIt.inflate(obj)

    expect(inflated.one).to.equal 1
    expect(inflated.two).to.equal 2
    expect(inflated.nested.three).to.equal 3
    expect(inflated.nested.more.four).to.equal 4
    expect(inflated.nested.crazy.scream.five).to.equal 5
    expect(inflated.nested).to.not.have.property 'more.four'
    expect(inflated.nested).to.not.have.property 'crazy.scream.five'
    expect(inflated.nested.crazy).to.not.have.property 'scream.five'
