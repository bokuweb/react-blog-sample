color = require 'color'

module.exports =
  color : "#FFF"
  background : "#1ABC9C"
  border : "solid 1px #1ABC9C"
  fontSize : "12px"
  ':hover' :
    background : color("#1ABC9C").lighten(0.1).hexString()
    border : "solid 1px #{color("#1ABC9C").lighten(0.1).hexString()}"
