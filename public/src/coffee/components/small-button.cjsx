jade            = require 'react-jade'
_               = require 'lodash'
Radium          = require 'radium'
smallButtonBase = require './styles/small-button-base'

smallButton = React.createClass
  render : ->
    jade.compile("""
      a(onClick=handleClick
        style=[smallButtonBase, buttonStyle])= buttonText
    """)(_.assign {}, @, @props)

module.exports = Radium smallButton
