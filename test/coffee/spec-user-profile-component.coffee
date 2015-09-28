global.React  ?= require 'react/addons'
assert         = require 'power-assert'
UserProfile    = require '../../public/src/coffee/components/user-profile'

TestUtils = React.addons.TestUtils

describe "UserProfile Component test", ->
  avatarImage = "http://hogehoge/path_to_avatar_image"
  username = "bokuweb"

  it 'Should UserProfile have author image, greeting', ->
    component = TestUtils.renderIntoDocument(<UserProfile avatarImage=avatarImage username=username />)
    imgs = TestUtils.scryRenderedDOMComponentsWithTag(component, 'img')
    assert.equal React.findDOMNode(imgs[0]).src, "http://hogehoge/path_to_avatar_image"
    assert.equal imgs.length, 1
    ps = TestUtils.scryRenderedDOMComponentsWithTag(component, 'p')
    assert.equal React.findDOMNode(ps[0]).textContent, "Hello!!#{username}"
    assert.equal ps.length, 1
    spans = TestUtils.scryRenderedDOMComponentsWithTag(component, 'span')
    assert.equal React.findDOMNode(spans[0]).textContent, username
    assert.equal spans.length, 1

