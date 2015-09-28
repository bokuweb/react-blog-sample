global.React  ?= require 'react/addons'
assert         = require 'power-assert'
SmallButton    = require '../../public/src/coffee/components/small-button'

TestUtils = React.addons.TestUtils

describe "SmallButton Component test", ->

  it 'Should SmallButton have "Test" text', ->
    component = TestUtils.renderIntoDocument(<SmallButton buttonText="Test" />)
    assert.equal React.findDOMNode(component).textContent, "Test"

  it 'Should SmallButton execute "onclick", when clicked', ->
    onClick = ->
      assert.ok true, 'execute onclick'

    component = TestUtils.renderIntoDocument(<SmallButton buttonText="Test" handleClick=onClick />)
    TestUtils.Simulate.click React.findDOMNode(component)
