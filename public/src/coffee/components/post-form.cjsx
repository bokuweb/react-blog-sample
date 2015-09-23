Fluxxor         = require 'fluxxor'
FluxMixin       = Fluxxor.FluxMixin React

PostForm = React.createClass
  mixins : [FluxMixin]
  handleSubmit : (e) ->
    e.preventDefault()
    title = React.findDOMNode(@refs.title).value.trim()
    text = React.findDOMNode(@refs.text).value.trim()
    return if not text or not title or not @props.author?
    article =
      title     : title
      author    : @props.author
      text      : text
      createdAt : new Date()
      updatedAt : new Date()
    React.findDOMNode(@refs.title).value = ''
    React.findDOMNode(@refs.text).value = ''
    @getFlux().actions.article.saveArticle article

  render : ->
    if @props.author
      <div className="postForm">
        <h1>Add New Post</h1>
        <input className="title-edit" placeholder="title" ref="title" />
        <textarea className="text-edit" ref="text" />
        <a href="#" className="button-post" onClick={@handleSubmit}>Post</a>
      </div>
    else
      <div></div>

module.exports = PostForm