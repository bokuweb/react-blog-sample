global.React  ?= require 'react/addons'
assert         = require 'power-assert'
GuestProfile   = require '../../public/src/coffee/components/guest-profile'

TestUtils = React.addons.TestUtils

describe "GuestProfile Component test", ->
  avatarImage = "http://hogehoge/path_to_avatar_image"

  it 'Should GuestProfile have guest image, greeting', ->
    component = TestUtils.renderIntoDocument(<GuestProfile avatarImage=avatarImage />)
    imgs = TestUtils.scryRenderedDOMComponentsWithTag(component, 'img')
    assert.equal React.findDOMNode(imgs[0]).src, "http://hogehoge/path_to_avatar_image"
    assert.equal imgs.length, 1
    h2s = TestUtils.scryRenderedDOMComponentsWithTag(component, 'h2')
    assert.equal React.findDOMNode(h2s[0]).textContent, "Hello!!"
    assert.equal imgs.length, 1
    ps = TestUtils.scryRenderedDOMComponentsWithTag(component, 'p')
    assert.equal React.findDOMNode(ps[0]).textContent, "Plaese login to edit this blog"
    assert.equal ps.length, 1

