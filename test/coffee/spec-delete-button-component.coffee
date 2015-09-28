global.React  ?= require 'react/addons'
assert         = require 'power-assert'
Fluxxor        = require 'fluxxor'
ArticlesStore  = require '../../public/src/coffee/stores/article-store'
DeleteButton   = require '../../public/src/coffee/components/delete-button'

TestUtils = React.addons.TestUtils

describe "DeleteButton Component test", ->

  it 'Should DeleteButton have "Delete" text', ->
    stores =
      ArticlesStore : new ArticlesStore()
    flux = new Fluxxor.Flux stores, {}
    component = TestUtils.renderIntoDocument(<DeleteButton flux={flux}/>)
    assert.equal React.findDOMNode(component).textContent, "Delete"

  it 'Should DeleteButton execute showDeleteModal action, when clicked', ->
    stores =
      ArticlesStore : new ArticlesStore()
    actions =
      article :
        showDeleteModal : (id) ->
          assert.equal id, "clicktestid"
    article =
      _id : "clicktestid"
    flux = new Fluxxor.Flux stores, actions
    component = TestUtils.renderIntoDocument(<DeleteButton article=article flux={flux}/>)
    TestUtils.Simulate.click React.findDOMNode(component)
