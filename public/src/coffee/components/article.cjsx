Fluxxor         = require 'fluxxor'
marked          = require 'marked'
PostInformation = require './post-information'
EditButton      = require './edit-button'
DeleteButton    = require './delete-button'
EditBox         = require './edit-box'
FluxMixin       = Fluxxor.FluxMixin React

Article = React.createClass
  mixins : [FluxMixin]

  render : ->
    rawMarkup = marked(@props.children.toString(), {
      renderer : new marked.Renderer()
      gfm : true
      tables : true
      breaks : true
      pedantic : false
      sanitize : true
      smartLists : true
    })
    
    hiddenUnlessAuthor = if @props.article._id? and @props.article.author is @props.username then "" else "hidden"
    <div className = "article">
      <h1 className = "title">{@props.article.title}</h1>
      <PostInformation article = {@props.article} />
      <span dangerouslySetInnerHTML = {{__html: rawMarkup}} />
      <div className = "article-footer #{hiddenUnlessAuthor}">
        <DeleteButton article = {@props.article} />
        <EditButton article = {@props.article} />
      </div>
      <EditBox article = {@props.article} />
    </div>

module.exports = Article
