Fluxxor         = require 'fluxxor'
jade            = require 'react-jade'
_               = require 'lodash'
Radium          = require 'radium'
smallButtonBase = require './styles/small-button-base'
postButton      = require './styles/post-button'

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
      jade.compile("""
        .postForm
          h1 Add New Post
          input.title-edit(placeholder="title" ref="title")
          textarea.text-edit(ref="text")
          a.button-post(href="#" onClick=handleSubmit style=[smallButtonBase, postButton]) Post
      """)(_.assign {}, @, @props)
    else
      jade.compile("div")()

module.exports = Radium PostForm
