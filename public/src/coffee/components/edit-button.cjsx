Fluxxor   = require 'fluxxor'
FluxMixin = Fluxxor.FluxMixin React

EditButton = React.createClass
  mixins : [FluxMixin]
  handleEditClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.editArticle @props.article._id

  render : ->
    if @props.article.isEditing
      <a href="#" className="button-editing" onClick={@handleEditClick}>cancel</a>
    else
      <a href="#" className="button-edit" onClick={@handleEditClick}>Edit</a>

module.exports = EditButton
