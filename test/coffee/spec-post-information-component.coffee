global.React   ?= require 'react/addons'
assert          = require 'power-assert'
moment          = require 'moment'
PostInformation = require '../../public/src/coffee/components/post-information'

TestUtils = React.addons.TestUtils

describe "PostInformation Component test", ->

  it 'Should PostInformation have author image, createdAt and updatedAt', ->
    now = new Date()
    article =
      createdAt : now
      updatedAt : now
      author    : "bokuweb"

    component = TestUtils.renderIntoDocument(<PostInformation article=article />)
    imgs = TestUtils.scryRenderedDOMComponentsWithTag(component, 'img')
    assert.equal React.findDOMNode(imgs[0]).src, "http://gadgtwit.appspot.com/twicon/bokuweb/mini"
    assert.equal imgs.length, 1
    spans = TestUtils.scryRenderedDOMComponentsWithTag(component, 'span')
    assert.equal React.findDOMNode(spans[1]).textContent, "bokuweb"
    assert.equal React.findDOMNode(spans[2]).textContent, "created at #{moment(now).format('lll')}"
    assert.equal React.findDOMNode(spans[3]).textContent, "updated at #{moment(now).format('lll')}"
    assert.equal spans.length, 4

  it 'Should updatedAt styles set "display:none", when createdAt equals updatedAt', ->
    now = new Date()
    article =
      createdAt : now
      updatedAt : now
      author    : "bokuweb"

    component = TestUtils.renderIntoDocument(<PostInformation article=article />)
    spans = TestUtils.scryRenderedDOMComponentsWithTag(component, 'span')
    assert.notEqual React.findDOMNode(spans[2]).style.display, "none"
    assert.equal React.findDOMNode(spans[3]).style.display, "none"

  it 'Should not updatedAt styles set "display:none", when createdAt not equal updatedAt', ->
    now = new Date()
    article =
      createdAt : now
      updatedAt : now + 1
      author    : "bokuweb"

    component = TestUtils.renderIntoDocument(<PostInformation article=article />)
    spans = TestUtils.scryRenderedDOMComponentsWithTag(component, 'span')
    assert.notEqual React.findDOMNode(spans[2]).style.display, "none"
    assert.notEqual React.findDOMNode(spans[3]).style.display, "none"

