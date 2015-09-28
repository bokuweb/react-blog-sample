global.React  ?= require 'react/addons'
assert         = require 'power-assert'
Fluxxor        = require 'fluxxor'
PostForm       = require '../../public/src/coffee/components/post-form'

TestUtils = React.addons.TestUtils

describe "PostFrom Component test", ->

  it 'Should Postform excute postFrom.enterTitle/enterText when authenticated and onchange', ->
    actions =
      postForm :
        enterTitle : (value) -> assert.equal value, "entertitle"
        enterText : (value) -> assert.equal value, "entertext"
    title = ""
    text = ""

    flux = new Fluxxor.Flux {}, actions
    component = TestUtils.renderIntoDocument(<PostForm title=title text=text author="bokuweb" flux={flux}/>)
    input = TestUtils.scryRenderedDOMComponentsWithTag(component, 'input')
    TestUtils.Simulate.change input[0], { target: { value: 'entertitle' }}
    textarea = TestUtils.scryRenderedDOMComponentsWithTag(component, 'textarea')
    TestUtils.Simulate.change textarea[0], { target: { value: 'entertext' }}
