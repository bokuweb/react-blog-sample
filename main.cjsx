window.React ?= require 'react'
Fluxxor       = require 'fluxxor'

constants =
  POST_ARTICLE   : "POST_ARTICLE"
  FETCH_ARTICLES : "FETCH_ARTICLES"

# Store
ArticlesStore = Fluxxor.createStore
  initialize : ->
    @articles = []
    @bindActions constants.FETCH_ARTICLES, @onFetchArticles
    @bindActions constants.POST_ARTICLE, @onUpdateArticles

  onFetchArticles : (payload) ->
    @articles = payload.articles
    @emit "change"

  onUpdateArticles : (payload) ->
    @articles = [payload.article].concat @articles
    @emit "change"

  getState : ->
    {articles : @articles}

# Action
actions =
  fetchArticles : ->
    console.log "read"
    $.ajax
      url: "/api/v1/read"
      dataType: 'json'
      cache: false
      success: (articles) =>
        console.dir articles
        @dispatch constants.FETCH_ARTICLES, {articles : articles}
      error : (xhr, status, err) =>
        console.error "/api/v1/read", status, err.toString()

  saveArticle : (article) ->
    $.ajax
      url: "/api/v1/save"
      dataType: 'json'
      type: 'POST'
      data: article
      success: (article) =>
        @dispatch constants.POST_ARTICLE, {article : article}
      error : (xhr, status, err) ->
        console.error "/api/v1/save", status, err.toString()

# Mixin
FluxMixin = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin

# View
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
    console.log "didmount"
    @getFlux().actions.fetchArticles()

  render : ->
    <div className="commentBox">
      <h1>Comments</h1>
        <CommentList articles = {@state.articles} />
        <CommentForm onCommentSubmit = {@handleCommentSubmit} />
    </div>

stores = {ArticlesStore : new ArticlesStore()}
flux = new Fluxxor.Flux stores, actions

React.render(
  <CommentBox flux = {flux} />,
  document.getElementById('content')
)

