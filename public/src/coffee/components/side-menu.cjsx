Fluxxor         = require 'fluxxor'
FluxMixin       = Fluxxor.FluxMixin React

GuestProfile = React.createClass
  render : ->
    <div id="profile">
      <img src={@props.avatarImage} className="avatar" />
      <h2 className="greeting">Hello!!</h2>
      <p className="please-login">Plaese login to edit this blog</p>
      <a href="./login" className="button-login">Login</a>
    </div>

UserProfile = React.createClass
  render : ->
    <div id="profile">
      <img src={@props.avatarImage} className="avatar" />
      <p className="please-login">Hello!! {@props.username}</p>
      <a href="./logout" className="button-login">Logout</a>
    </div>

SideMenu = React.createClass
  mixins : [FluxMixin]

  componentDidMount : ->
    @getFlux().actions.profile.fetchProfile()

  render : ->
    if @props.isProfileFetching
      <div id="side-menu">
        <img src="image/logo.png" className="logo" />
        <i className="fa fa-spinner fa-spin loading"></i>
      </div>
    else
      if @props.profile.error?
        <div id="side-menu">
          <img src="image/logo.png" className="logo" />
          <GuestProfile avatarImage = {"image/guest.png"} />
        </div>
      else
        avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.profile.username}/bigger"
        <div id="side-menu">
          <img src="image/logo.png" className="logo" />
          <UserProfile
            avatarImage = {avatarUrl}
            username = {@props.profile.username} />
        </div>

module.exports = SideMenu
