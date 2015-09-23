jade      = require 'react-jade'
_         = require 'lodash'

UserProfile = React.createClass
  render : ->
    jade.compile("""
      #profile
        img.avatar(src=avatarImage)
        p.please-login Hello!!
          span= username
        a.button-login(href="./logout") Logout
    """)(_.assign {}, @, @props)

module.exports = UserProfile
