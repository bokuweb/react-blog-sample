global.React  ?= require 'react/addons'
assert         = require 'power-assert'
Fluxxor        = require 'fluxxor'
SearchBox      = require '../../public/src/coffee/components/search-box'

TestUtils = React.addons.TestUtils

describe "SearchBox Component test", ->

  it 'Should searchBox.search execute, when input changed', ->
    actions =
      searchBox :
        search : (value) -> assert.equal value, 'keyinputtest'

    search = ""

    flux = new Fluxxor.Flux {}, actions
    component = TestUtils.renderIntoDocument(<SearchBox search=search flux={flux}/>)
    input = TestUtils.scryRenderedDOMComponentsWithTag(component, 'input')
    TestUtils.Simulate.change input[0], { target: { value: 'keyinputtest' }}
