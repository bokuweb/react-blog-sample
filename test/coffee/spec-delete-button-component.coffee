global.React   = require 'react/addons'
assert         = require 'power-assert'
Fluxxor        = require 'fluxxor'
ArticlesStore  = require '../../public/src/coffee/stores/article-store'
DeleteButton   = require '../../public/src/coffee/components/delete-button'

TestUtils = React.addons.TestUtils

stores =
  ArticlesStore : new ArticlesStore()

flux = new Fluxxor.Flux stores, {}

describe "MenuListComponent view test", ->
  it "test", ->
    console.log "test"
    component = TestUtils.renderIntoDocument(<DeleteButton flux={flux}/>)
    assert.equal React.findDOMNode(component).textContent, "Delete"


