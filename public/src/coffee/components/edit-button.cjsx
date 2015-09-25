Fluxxor         = require 'fluxxor'
jade            = require 'react-jade'
_               = require 'lodash'
Radium          = require 'radium'
smallButtonBase = require './styles/small-button-base'
editButton      = require './styles/edit-button'
cancelButton    = require './styles/cancel-button'
FluxMixin       = Fluxxor.FluxMixin React

EditButton = React.createClass
  mixins : [FluxMixin]
  handleEditClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.editArticle @props.article._id

  render : ->
    if @props.article.isEditing
      jade.compile("""
        a.button-editing(onClick=handleEditClick
                         style=[smallButtonBase, cancelButton]) Cancel
      """)(_.assign {}, @, @props)
    else
      jade.compile("""
        a.button-edit(onClick=handleEditClick
                      style=[smallButtonBase, editButton]) Edit
      """)(_.assign {}, @, @props)


module.exports = Radium EditButton
