Fluxxor   = require 'fluxxor'
jade      = require 'react-jade'
_         = require 'lodash'
FluxMixin = Fluxxor.FluxMixin React

EditButton = React.createClass
  mixins : [FluxMixin]
  handleEditClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.editArticle @props.article._id

  render : ->
    if @props.article.isEditing
      jade.compile("a.button-editing(onClick=handleEditClick) cancel")(_.assign {}, @, @props)
    else
      jade.compile("a.button-edit(onClick=handleEditClick) Edit")(_.assign {}, @, @props)

module.exports = EditButton
