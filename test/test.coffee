# build time tests for shell plugin
# see http://mochajs.org/

shell = require '../client/shell'
expect = require 'expect.js'

describe 'shell plugin', ->

  describe 'expand', ->

    it 'can break lines', ->
      result = shell.expand "hello\nworld"
      expect(result).to.be 'hello<br>world'

    it 'can remove backspace overstrikes', ->
      result = shell.expand "H\bHE\bEL\bLL\bLO\bO"
      expect(result).to.be 'HELLO'
