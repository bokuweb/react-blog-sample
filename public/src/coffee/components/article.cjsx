Fluxxor         = require 'fluxxor'
marked          = require 'marked'
Radium          = require 'radium'
highlight       = require 'highlight.js'
articleStyle    = require './styles/article'
commonStyle     = require './styles/common'
PostInformation = require './post-information'
EditButton      = require './edit-button'
DeleteButton    = require './delete-button'
EditBox         = require './edit-box'
jade            = require 'react-jade'
_               = require 'lodash'

FluxMixin       = Fluxxor.FluxMixin React

Article = React.createClass
  mixins : [FluxMixin]

  render : ->
    option =
      renderer : new marked.Renderer()
      highlight : (code, lang) ->
        return highlight.highlightAuto(code, [lang]).value
      gfm : true
      tables : true
      breaks : true
      pedantic : false
      sanitize : true
      smartLists : true

    # if editing real time preview edit text and title
    if @props.article.isEditing
      rawMarkup = marked @props.article.editingText, option
      title =  @props.article.editingTitle
    else
      rawMarkup = marked @props.children.toString(), option
      title =  @props.article.title

    # set delted style if post deleted
    style = if @props.article.isDeletedy
      [articleStyle.article, articleStyle.articleDeleted]
    else articleStyle.article

    hiddenUnlessAuthor = if @props.article._id? and @props.article.author is @props.username
      {margin: "30px 0 0 0"}
    else commonStyle.hidden
    jade.compile("""
      div(style=style)
        div.animated.fadeInUp
          h1(style=commonStyle.h1)= title
          PostInformation(article=article)
          span(dangerouslySetInnerHTML={__html: rawMarkup})
          div(style=hiddenUnlessAuthor)
            DeleteButton(article=article)
            EditButton(article=article)
          EditBox(article=article)
    """)(_.assign {}, @, @props)

module.exports = Radium Article
