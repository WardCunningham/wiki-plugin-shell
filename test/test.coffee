# build time tests for shell plugin
# see http://mochajs.org/

shell = require '../client/shell'
expect = require 'expect.js'

describe 'shell plugin', ->

  describe 'expand', ->

    it 'can make itallic', ->
      result = shell.expand 'hello *world*'
      expect(result).to.be 'hello <i>world</i>'
