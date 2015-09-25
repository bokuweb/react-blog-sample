jade         = require 'react-jade'
_            = require 'lodash'
Radium       = require 'radium'
profileStyle = require './styles/profile'

GuestProfile = React.createClass
  render : ->
    jade.compile("""
      #profile(style=profileStyle.profile)
        img(src=avatarImage style=profileStyle.avatar)
        h2(style=profileStyle.greeting) Hello!!
        p(style=profileStyle.pleaseLogin) Plaese login to edit this blog
        a(href="./login" style=profileStyle.loginButton) Login
    """)(_.assign {}, @, @props)

module.exports = GuestProfile
