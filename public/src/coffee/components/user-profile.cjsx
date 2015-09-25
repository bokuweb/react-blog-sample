jade         = require 'react-jade'
_            = require 'lodash'
Radium       = require 'radium'
profileStyle = require './styles/profile'

UserProfile = React.createClass
  render : ->
    jade.compile("""
      #profile(style=profileStyle.profile)
        img(src=avatarImage style=profileStyle.avatar)
        p(style=profileStyle.pleaseLogin) Hello!!
          span= username
        a(href="./logout" style=profileStyle.loginButton) Logout
    """)(_.assign {}, @, @props)

module.exports = Radium UserProfile
