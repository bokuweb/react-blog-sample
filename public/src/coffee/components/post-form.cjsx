Fluxxor            = require 'fluxxor'
jade               = require 'react-jade'
_                  = require 'lodash'
Radium             = require 'radium'
smallButtonBase    = require './styles/small-button-base'
postButton         = require './styles/post-button'
postButton_disable = require './styles/post-button-disable'
postForm           = require './styles/post-form'
commonStyle        = require './styles/common'

FluxMixin = Fluxxor.FluxMixin React

PostForm = React.createClass
  mixins : [FluxMixin]

  enterTitle : (e) ->
    @getFlux().actions.postForm.enterTitle e.target.value

  enterText : (e) ->
    @getFlux().actions.postForm.enterText e.target.value

  isEnteredTitleAndTextByUser : ->
    @props.text and @props.title and @props.author?

  handleSubmit : (e) ->
    e.preventDefault()
    return if not @isEnteredTitleAndTextByUser()
    article =
      title     : @props.title
      author    : @props.author
      text      : @props.text
      createdAt : new Date()
      updatedAt : new Date()
    @getFlux().actions.postForm.saveArticle article

  render : ->
    if @isEnteredTitleAndTextByUser()
      postButtonStyle = [smallButtonBase, postButton]
    else
      postButtonStyle = [smallButtonBase, postButton_disable]

    if @props.author
      jade.compile("""
        div(style=postForm.postForm)
          h1(style=commonStyle.h1) Add New Post
          input(placeholder="title" ref="title" style=postForm.titleEditor value=title onChange=enterTitle)
          textarea(ref="text" style=postForm.textEditor value=text onChange=enterText)
          a(href="#" onClick=handleSubmit style=postButtonStyle) Post
      """)(_.assign {}, @, @props)
    else
      jade.compile("div")()

module.exports = Radium PostForm
