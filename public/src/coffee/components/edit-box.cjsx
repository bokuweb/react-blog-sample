Fluxxor         = require 'fluxxor'
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
    showIfEditing = if @props.article.isEditing then "editing" else ""
    <div className="editor #{showIfEditing}">
      <input className="title-edit" ref="editingTitle" value=@props.article.editingTitle onChange={@editTitle} />
      <textarea className="text-edit" ref="editingText" value=@props.article.editingText onChange={@editText} />
      <a href="#" className="button-update" onClick={@handleUpdateClick}>Update</a>
    </div>

module.exports = EditBox
