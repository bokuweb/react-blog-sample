Fluxxor         = require 'fluxxor'
marked          = require 'marked'
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
    rawMarkup = marked @props.children.toString(),
      renderer : new marked.Renderer()
      gfm : true
      tables : true
      breaks : true
      pedantic : false
      sanitize : true
      smartLists : true

    hiddenUnlessAuthor = if @props.article._id? and @props.article.author is @props.username then "" else "hidden"
    jade.compile("""
      .article
        h1.title= article.title
        PostInformation(article=article)
        span(dangerouslySetInnerHTML={__html: rawMarkup})
        div.article-footer(class=hiddenUnlessAuthor)
          DeleteButton(article=article)
          EditButton(article=article)
        EditBox(article=article)
    """)(_.assign {}, @, @props)

module.exports = Article
