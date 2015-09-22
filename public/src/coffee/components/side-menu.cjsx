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
    if @props.isFetching
      <i className="fa fa-spinner fa-spin loading"></i>
    else
      if @props.profile.error?
        <GuestProfile avatarImage = {"image/guest.png"} />
      else
        avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.profile.username}/bigger"
        <UserProfile
          avatarImage = {avatarUrl}
          username = {@props.profile.username} />

module.exports = SideMenu
