jade            = require 'react-jade'
_               = require 'lodash'
Fluxxor         = require 'fluxxor'
FluxMixin       = Fluxxor.FluxMixin React

DeleteButton = React.createClass
  mixins : [FluxMixin]
  handleDeleteClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.deleteArticle @props.article._id

  render : ->
    jade.compile("a.button-delete(onClick=handleDeleteClick) Delete")(_.assign {}, @, @props)

module.exports = DeleteButton
