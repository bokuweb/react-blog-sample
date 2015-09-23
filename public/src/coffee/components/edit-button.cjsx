Fluxxor   = require 'fluxxor'
jade      = require 'react-jade'
_         = require 'lodash'
Radium    = require 'radium'
FluxMixin = Fluxxor.FluxMixin React

style =
  base :
    color : "#FFF"
    background : "#D35400"
    display : "inline-block"
    width : "80px"
    borderRadius : "3px"
    border : "solid 1px #D35400"
    padding : "0px 6px 0px 6px"
    textDecoration : "none"
    textAlign : "center"
    transition : "all 0.2s ease"
    textShadow : "none"
    fontSize : "12px"
    margin : "0 10px 0 0"
    cursor : "pointer"
  test :
    color : "#000"


EditButton = React.createClass
  mixins : [FluxMixin]
  handleEditClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.editArticle @props.article._id

  render : ->
    # if using "react-jade", can't use radium mixin
    styles = _.assign {}, style.base, style.test
    if @props.article.isEditing
      jade.compile("""
        a.button-editing(onClick=handleEditClick style=styles) Cancel
      """)(_.assign {}, @, @props)
    else
      jade.compile("a.button-edit(onClick=handleEditClick) Edit")(_.assign {}, @, @props)


module.exports = EditButton
