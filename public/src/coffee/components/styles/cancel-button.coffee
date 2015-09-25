color = require 'color'

module.exports =
  color : "#FFF"
  background : "#D35400"
  border : "solid 1px #D35400"
  fontSize : "12px"
  width : "80px"
  ':hover' :
    background : color("#D35400").lighten(0.8).hexString()
    border : "solid 1px #{color("#D35400").lighten(0.8).hexString()}"

