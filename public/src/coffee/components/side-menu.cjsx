Fluxxor       = require 'fluxxor'
jade          = require 'react-jade'
_             = require 'lodash'
Radium        = require 'radium'
sideMenuStyle = require './styles/side-menu'
UserProfile   = require './user-profile'
GuestProfile  = require './guest-profile'
SearchBox     = require './search-box'
FluxMixin     = Fluxxor.FluxMixin React

SideMenu = React.createClass
  mixins : [FluxMixin]

  componentDidMount : ->
    @getFlux().actions.profile.fetchProfile()

  render : ->
    if @props.isProfileFetching
      jade.compile("""
        #side-menu(style=sideMenuStyle.sideMenu)
          img(src="image/logo.png" style=sideMenuStyle.logo)
          i.fa.fa-spinner.fa-spin(style=sideMenuStyle.loading)
      """)(_.assign {}, @, @props)
    else
      if @props.profile.error?
        jade.compile("""
          #side-menu(style=sideMenuStyle.sideMenu)
            img(src="image/logo.png" style=sideMenuStyle.logo)
            GuestProfile(avatarImage="image/guest.png")
        """)(_.assign {}, @, @props)
      else
        avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.profile.username}/bigger"
        jade.compile("""
          #side-menu(style=sideMenuStyle.sideMenu)
            img(src="image/logo.png" style=sideMenuStyle.logo)
            UserProfile(avatarImage=avatarUrl username=profile.username)
            SearchBox(search=search)
        """)(_.assign {}, @, @props)

module.exports = Radium SideMenu
