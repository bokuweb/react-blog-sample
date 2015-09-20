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
      <Comment author={comment.author} key={comment._id}>
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
    article =
      title : title
      author: author
      text: text
      createdAt : new Date()
      updatedAt : new Date()
    React.findDOMNode(@refs.title).value = ''
    React.findDOMNode(@refs.author).value = ''
    React.findDOMNode(@refs.text).value = ''
    @getFlux().actions.article.saveArticle article

  render : ->
    <form className="commentForm" onSubmit={@handleSubmit}>
      <input type="text" placeholder="Say something..." ref="title" />
      <input type="text" placeholder="Your name" ref="author" />
      <input type="text" placeholder="Say something..." ref="text" />
      <input type="submit" value="Post" />
    </form>

CommentBox = React.createClass
  mixins : [
    FluxMixin
    StoreWatchMixin "ArticlesStore", "ProfileStore"
  ]

  getStateFromFlux : ->
    flux = this.getFlux()
    {
      articleStore : flux.store("ArticlesStore").getArticles()
      profileStore : flux.store("ProfileStore").getState()
    }
  componentDidMount : ->
    @getFlux().actions.article.fetchArticles()

  render : ->
    <div id="container">
      <div id="side-menu">
        <SideMenu profile = {@state.profileStore.profile} />
      </div>
      <div id="content">
        <div className="commentBox">
          <CommentList articles = {@state.articleStore.articles} />
          <CommentForm />
        </div>
      </div>
    </div>

GuestProfile = React.createClass
  render : ->
    <div id="profile">
      <img src={@props.avatarImage} className="avatar" />
      <p className="please-login">Hello!!<br />Plaese login to edit this blog</p>
      <a href="./login" className="button-login">Login</a>
    </div>

SideMenu = React.createClass
  mixins : [FluxMixin]

  componentDidMount : ->
    @getFlux().actions.profile.fetchProfile()

  render : ->
    if @props.profile.error
      <GuestProfile avatarImage = {"image/guest.png"} />
    else
      <div>
        <span>
          {@props.profile.id}
        </span>
        <span>asdas</span>
      </div>


module.exports = CommentBox
