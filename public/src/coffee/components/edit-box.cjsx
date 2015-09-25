Fluxxor         = require 'fluxxor'
jade            = require 'react-jade'
_               = require 'lodash'
Radium          = require 'radium'
smallButtonBase = require './styles/small-button-base'
postButton      = require './styles/post-button'
editBox         = require './styles/edit-box'
FluxMixin       = Fluxxor.FluxMixin React

EditBox = React.createClass
  mixins : [FluxMixin]

  editTitle : (e) ->
    @getFlux().actions.article.editTitle @props.article._id, e.target.value

  editText : (e) ->
    @getFlux().actions.article.editText @props.article._id, e.target.value

  handleUpdateClick : (e) ->
    e.preventDefault()
    text = React.findDOMNode(@refs.editingText).value.trim()
    title = React.findDOMNode(@refs.editingTitle).value.trim()
    article =
      _id       : @props.article._id
      title     : title
      author    : @props.article.author
      text      : text
      createdAt : @props.article.createdAt
      updatedAt : new Date()
    @getFlux().actions.article.updateArticle @props.article._id, article

  render : ->
    #showIfEditing = if @props.article.isEditing then "editing" else ""
    editorStyle = if @props.article.isEditing then editBox.editing else editBox.notEditing
    jade.compile("""
      div(style=editorStyle)
        input(ref="editingTitle" value=article.editingTitle onChange=editTitle style=editBox.titleEditor)
        textarea(ref="editingText" value=article.editingText onChange=editText style=editBox.textEditor)
        a(onClick=handleUpdateClick style=[smallButtonBase, postButton]) Update
    """)(_.assign {}, @, @props)

module.exports = Radium EditBox
