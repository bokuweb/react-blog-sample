Fluxxor   = require 'fluxxor'
jade      = require 'react-jade'
_         = require 'lodash'
FluxMixin = Fluxxor.FluxMixin React

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
    showIfEditing = if @props.article.isEditing then "editing" else ""
    jade.compile("""
      div.editor(class=showIfEditing)
        input.title-edit(ref="editingTitle" value=article.editingTitle onChange=editTitle)
        textarea.text-edit(ref="editingText" value=article.editingText onChange=editText)
        a.button-update(onClick=handleUpdateClick) Update
    """)(_.assign {}, @, @props)
    
module.exports = EditBox
