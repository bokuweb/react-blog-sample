jade            = require 'react-jade'
_               = require 'lodash'
marked          = require 'marked'
PostInformation = require './post-information'
commonStyle     = require './styles/common'
blogStyle       = require './styles/blog'
articleStyle    = require './styles/article'

PostPreview = React.createClass
  render : ->
    option =
      renderer : new marked.Renderer()
      gfm : true
      tables : true
      breaks : true
      pedantic : false
      sanitize : true
      smartLists : true

    if @props.title.length is 0 and @props.text.length is 0
      return <div />
    rawMarkup = marked @props.text, option
    title =  @props.title
    now = new Date()
    article =
      createdAt : now
      updatedAt : now
      author    : @props.author
    #previewH1 =
      #display : "inline-block"
      #background : "#EAE5DE"
      #padding : "5px 20px"
      #borderRadius : "10px"

    jade.compile("""
      div.animated.fadeInUp(style=blogStyle.articles)
        h1 Preview
        h1(style=commonStyle.h1)= title
        PostInformation(article=article)
        span(dangerouslySetInnerHTML={__html: rawMarkup})
    """)(_.assign {}, @, @props)

module.exports = PostPreview
