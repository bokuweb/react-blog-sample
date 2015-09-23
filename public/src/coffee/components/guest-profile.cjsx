jade      = require 'react-jade'
_         = require 'lodash'

GuestProfile = React.createClass
  render : ->
    jade.compile("""
      #profile
        img.avatar(src=avatarImage)
        h2.greeting Hello!!
        p.please-login Plaese login to edit this blog
        a.button-login(href="./login") Login
    """)(_.assign {}, @, @props)

module.exports = GuestProfile
