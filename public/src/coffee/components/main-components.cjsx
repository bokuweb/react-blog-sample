Fluxxor         = require 'fluxxor'
FluxMixin       = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin

Article = React.createClass
  mixins : [FluxMixin]
  handleDeleteClick : (e) ->
    e.preventDefault()
    console.log "click"
    @getFlux().actions.article.deleteArticle @props.article._id

  render : ->
    rawMarkup = marked(@props.children.toString(), {sanitize: true})
    avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.article.author}/mini"
    # FIXME : fix animation
    isDeleted = if @props.article.isDeleted then "deleted" else ""
    isHidden  = unless @props.article._id? and @props.article.author is @props.username then "hidden" else ""
    # FIXME : fix animation
    <div className="article #{isDeleted}">
      <h1 className="title">
        {@props.article.title}
      </h1>
      <div className="post-infomation">
        <span className="author-name">
          <img src={avatarUrl} className="author-avatar-mini"/>
          {@props.article.author}
        </span>
        <span className="created-at">created at {@props.article.createdAt}</span>
      </div>
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
      <div className="article-footer">
        <a href="#" className="button-delete #{isHidden}" onClick={@handleDeleteClick}>Delete</a>
      </div>
    </div>

ArticleList = React.createClass
  render : ->
    if @props.articles.length >0
      articleNodes = @props.articles.map (article) =>
        <Article article={article},
                 key={article._id},
                 username={@props.username} >
          {article.text}
        </Article>

      <div className="commentList">
        {articleNodes}
      </div>
    else
      <h1>There are yet no article...</h1>

BlogForm = React.createClass
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
    <form className="commentForm" onSubmit={@handleSubmit}>
      <input type="text" placeholder="title..." ref="title" />
      <input type="text" placeholder="Say something..." ref="text" />
      <input type="submit" value="Post" />
    </form>

Blog = React.createClass
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
        <img src="image/logo.png" className="logo" />
        <SideMenu
          profile = {@state.profileStore.profile},
          isFetching = {@state.profileStore.isFetching}
         />
      </div>
      <div id="content">
        <div className="commentBox">
          <BlogForm author={@state.profileStore.profile.username}/>
          <div id="articles">
            <ArticleList articles={@state.articleStore.articles},
                         username={@state.profileStore.profile.username} />
          </div>
        </div>
      </div>
    </div>

GuestProfile = React.createClass
  render : ->
    <div id="profile">
      <img src={@props.avatarImage} className="avatar" />
      <h2 className="greeting">Hello!!</h2>
      <p className="please-login">Plaese login to edit this blog</p>
      <a href="./login" className="button-login">Login</a>
    </div>

UserProfile = React.createClass
  render : ->
    <div id="profile">
      <img src={@props.avatarImage} className="avatar" />
      <p className="please-login">Hello!! {@props.username}</p>
      <a href="./logout" className="button-login">Logout</a>
    </div>

SideMenu = React.createClass
  mixins : [FluxMixin]

  componentDidMount : ->
    @getFlux().actions.profile.fetchProfile()

  render : ->
    if @props.isFetching
      <span></span>
    else
      if @props.profile.error?
        <GuestProfile avatarImage = {"image/guest.png"} />
      else
        avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.profile.username}/bigger"
        <UserProfile
          avatarImage = {avatarUrl}
          username = {@props.profile.username}
        />

module.exports = Blog
