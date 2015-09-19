Fluxxor         = require 'fluxxor'
FluxMixin       = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin

Comment = React.createClass
  render : ->
    rawMarkup = marked(@props.children.toString(), {sanitize: true})
    <div className="comment">
      <h2 className="commentAuthor">
        {@props.author}
      </h2>
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
    </div>

CommentList = React.createClass
  render : ->
    commentNodes = @props.articles.map (comment) ->
      <Comment author={comment.author}>
        {comment.text}
      </Comment>

    <div className="commentList">
      {commentNodes}
    </div>

CommentForm = React.createClass
  mixins : [FluxMixin]
  handleSubmit : (e) ->
    e.preventDefault()
    title = React.findDOMNode(@refs.title).value.trim()
    author = React.findDOMNode(@refs.author).value.trim()
    text = React.findDOMNode(@refs.text).value.trim()
    return if not text or not author or not title
    #@props.onCommentSubmit
    article =
      title : title
      author: author
      text: text
      createdAt : new Date()
      updatedAt : new Date()
    React.findDOMNode(@refs.title).value = ''
    React.findDOMNode(@refs.author).value = ''
    React.findDOMNode(@refs.text).value = ''
    @getFlux().actions.saveArticle article

  render : ->
    <form className="commentForm" onSubmit={@handleSubmit}>
      <input type="text" placeholder="Say something..." ref="title" />
      <input type="text" placeholder="Your name" ref="author" />
      <input type="text" placeholder="Say something..." ref="text" />
      <input type="submit" value="Post" />
    </form>

CommentBox = React.createClass
  mixins : [FluxMixin, StoreWatchMixin "ArticlesStore"]

  getStateFromFlux : ->
    @getFlux().store("ArticlesStore").getState()

  componentDidMount : ->
    @getFlux().actions.fetchArticles()

  render : ->
    <div className="commentBox">
      <h1>Comments</h1>
        <CommentList articles = {@state.articles} />
        <CommentForm onCommentSubmit = {@handleCommentSubmit} />
    </div>

module.exports = CommentBox