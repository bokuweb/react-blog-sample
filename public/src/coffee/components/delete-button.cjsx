jade            = require 'react-jade'
_               = require 'lodash'
Fluxxor         = require 'fluxxor'
Radium          = require 'radium'
smallButtonBase = require './styles/small-button-base'
deleteButton    = require './styles/delete-button'
FluxMixin       = Fluxxor.FluxMixin React

DeleteButton = React.createClass
  mixins : [FluxMixin]
  handleDeleteClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.deleteArticle @props.article._id

  render : ->
    jade.compile("""
      a(onClick=handleDeleteClick
        style=[smallButtonBase, deleteButton]) Delete
    """)(_.assign {}, @, @props)

module.exports = Radium DeleteButton
