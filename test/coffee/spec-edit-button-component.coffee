global.React  ?= require 'react/addons'
assert         = require 'power-assert'
Fluxxor        = require 'fluxxor'
ArticlesStore  = require '../../public/src/coffee/stores/article-store'
EditButton     = require '../../public/src/coffee/components/edit-button'

TestUtils = React.addons.TestUtils

describe "DeleteButton Component test", ->
  CLICK_TEST_ID = "clicktestid"
  stores =
    ArticlesStore : new ArticlesStore()
  actions =
    article :
      editArticle : (id) ->
        assert.equal id, CLICK_TEST_ID
  flux = new Fluxxor.Flux stores, actions

  it 'Should EditButton have "Edit" text, when not editing', ->
    article =
      _id : CLICK_TEST_ID
      isEditing : false
    component = TestUtils.renderIntoDocument(<EditButton article=article flux={flux}/>)
    assert.equal React.findDOMNode(component).textContent, "Edit"

  it 'Should EditButton execute editArticle action, when clicked', ->
    article =
      _id : CLICK_TEST_ID
      isEditing : false
    component = TestUtils.renderIntoDocument(<EditButton article=article flux={flux}/>)
    TestUtils.Simulate.click React.findDOMNode(component)

  it 'Should EditButton have "Cancel" text, when editing', ->
    article =
      _id : CLICK_TEST_ID
      isEditing : true
    component = TestUtils.renderIntoDocument(<EditButton article=article flux={flux}/>)
    assert.equal React.findDOMNode(component).textContent, "Cancel"

  it 'Should EditButton execute editArticle action, when clicked', ->
    article =
      _id : CLICK_TEST_ID
      isEditing : true
    component = TestUtils.renderIntoDocument(<EditButton article=article flux={flux}/>)
    TestUtils.Simulate.click React.findDOMNode(component)
