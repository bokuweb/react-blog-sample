Fluxxor         = require 'fluxxor'
PostInformation = require './post-information'

FluxMixin       = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin

Article = React.createClass
  mixins : [FluxMixin]
  handleDeleteClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.deleteArticle @props.article._id

  handleEditClick : (e) ->
    e.preventDefault()
    @getFlux().actions.article.editArticle @props.article._id

  handleUpdateClick : (e) ->
    e.preventDefault()
    text = React.findDOMNode(@refs.editingText).value.trim()
    title = React.findDOMNode(@refs.editingTitle).value.trim()
    article =
      _id       : @props.article._id
      title     : title
      author    : @props.article.author
      text      : text
      createdAt : @props.article.createdAt
      updatedAt : new Date()
    @getFlux().actions.article.updateArticle @props.article._id, article

  editTitle : (e) ->
    @getFlux().actions.article.editTitle @props.article._id, e.target.value

  editText : (e) ->
    @getFlux().actions.article.editText @props.article._id, e.target.value

  render : ->
    rawMarkup = marked(@props.children.toString(), {sanitize: true})
    # FIXME : fix animation
    isDeleted = if @props.article.isDeleted then "deleted" else ""
    isEditing = if @props.article.isEditing then "editing" else ""
    isHidden  = if @props.article._id? and @props.article.author is @props.username then "" else "hidden"
    # FIXME : fix animation
    <div className="article #{isDeleted}">
      <h1 className="title">
        {@props.article.title}
      </h1>
      <PostInformation article={@props.article} />
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
      <div className="article-footer #{isHidden}">
        <a href="#" className="button-delete" onClick={@handleDeleteClick}>Delete</a>
        <a href="#" className="button-edit" onClick={@handleEditClick}>Edit</a>
      </div>
      <div className="editor #{isEditing}">
        <input className="title-edit" ref="editingTitle" value=@props.article.editingTitle onChange={@editTitle} />
        <textarea className="text-edit" ref="editingText" value=@props.article.editingText onChange={@editText} />
        <a href="#" className="button-update" onClick={@handleUpdateClick}>Update</a>
      </div>
    </div>

ArticleList = React.createClass
  render : ->
    if @props.articles.length >0
      articleNodes = @props.articles.map (article) =>
        <Article article={article}
                 key={article._id}
                 username={@props.username} >
          {article.text}
        </Article>

      <div className="commentList">
        {articleNodes}
      </div>
    else
      <h1>There are yet no article...</h1>

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
    isHidden  = if @props.author then "" else "hidden"
    <div className="postForm #{isHidden}">
      <h1>Add New Post</h1>
      <input className="title-edit" placeholder="title" ref="title" />
      <textarea className="text-edit" ref="text" />
      <a href="#" className="button-post" onClick={@handleSubmit}>Post</a>
    </div>

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
          isFetching = {@state.profileStore.isFetching} />
      </div>
      <div id="content">
        <PostForm author={@state.profileStore.profile.username}/>
        <div id="articles">
          <ArticleList articles={@state.articleStore.articles},
                       username={@state.profileStore.profile.username} />
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
