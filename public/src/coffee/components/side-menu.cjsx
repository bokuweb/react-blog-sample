Fluxxor      = require 'fluxxor'
jade         = require 'react-jade'
_            = require 'lodash'
UserProfile  = require './user-profile'
GuestProfile = require './guest-profile'
FluxMixin    = Fluxxor.FluxMixin React

SideMenu = React.createClass
  mixins : [FluxMixin]

  componentDidMount : ->
    @getFlux().actions.profile.fetchProfile()

  render : ->
    if @props.isProfileFetching
      jade.compile("""
        #side-menu
          img.logo(src="image/logo.png")
          i.fa.fa-spinner.fa-spin.loading
      """)(_.assign {}, @, @props)
    else
      if @props.profile.error?
        jade.compile("""
          #side-menu
            img.logo(src="image/logo.png")
            GuestProfile(avatarImage="image/guest.png")
        """)(_.assign {}, @, @props)
      else
        avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.profile.username}/bigger"
        jade.compile("""
          #side-menu
            img.logo(src="image/logo.png")
            UserProfile(avatarImage=avatarUrl username=profile.username)
        """)(_.assign {}, @, @props)

module.exports = SideMenu
