Fluxxor         = require 'fluxxor'
FluxMixin       = Fluxxor.FluxMixin React

DeleteButton = React.createClass
  mixins : [FluxMixin]
  handleDeleteClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.deleteArticle @props.article._id

  render : ->
    <a href="#" className="button-delete" onClick={@handleDeleteClick}>Delete</a>

module.exports = DeleteButton
