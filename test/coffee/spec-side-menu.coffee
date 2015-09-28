global.React  ?= require 'react/addons'
assert         = require 'power-assert'
Fluxxor        = require 'fluxxor'
SideMenu       = require '../../public/src/coffee/components/side-menu'
UserProfile    = require '../../public/src/coffee/components/user-profile'
GuestProfile    = require '../../public/src/coffee/components/guest-profile'
SearchBox      = require '../../public/src/coffee/components/search-box'

TestUtils = React.addons.TestUtils

describe "GuestProfile Component test", ->
  actions =
    profile :
      fetchProfile : (id) -> console.log "exec fetch profile"
  flux = new Fluxxor.Flux {}, actions

  it 'Should SideMenu have logo image, userProfile and aserchBox when authenticated', ->
    isProfileFetching = false
    profile =
      username : "bokuweb"
      error    : null
    component = TestUtils.renderIntoDocument(<SideMenu flux={flux}
                                                       profile=profile
                                                       isProfileFetching=isProfileFetching />)
    imgs = TestUtils.scryRenderedDOMComponentsWithTag(component, 'img')
    assert.equal imgs.length, 2
    userProfile = TestUtils.scryRenderedComponentsWithType(component, UserProfile)
    assert.equal userProfile.length, 1
    searchBox  = TestUtils.scryRenderedComponentsWithType(component, SearchBox)
    assert.equal searchBox.length, 1

  it 'Should SideMenu have logo image, guestProfile and aserchBox when not authenticated', ->
    isProfileFetching = false
    profile =
      error    : "not authenticated"
    component = TestUtils.renderIntoDocument(<SideMenu flux={flux}
                                                       profile=profile
                                                       isProfileFetching=isProfileFetching />)
    imgs = TestUtils.scryRenderedDOMComponentsWithTag(component, 'img')
    assert.equal imgs.length, 2
    guestProfile = TestUtils.scryRenderedComponentsWithType(component, GuestProfile)
    assert.equal guestProfile.length, 1
    searchBox  = TestUtils.scryRenderedComponentsWithType(component, SearchBox)
    assert.equal searchBox.length, 1

  it 'Should SideMenu have logo image and loading icon when fetching', ->
    isProfileFetching = true
    profile =
      error    : "not authenticated"
    component = TestUtils.renderIntoDocument(<SideMenu flux={flux}
                                                       profile=profile
                                                       isProfileFetching=isProfileFetching />)
    imgs = TestUtils.scryRenderedDOMComponentsWithTag(component, 'img')
    assert.equal imgs.length, 1
    icon  = TestUtils.scryRenderedDOMComponentsWithTag(component, 'i')
    assert.equal icon.length, 1
