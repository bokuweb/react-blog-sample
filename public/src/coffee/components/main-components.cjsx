Fluxxor         = require 'fluxxor'
PostInformation = require './post-information'
EditButton      = require './edit-button'
DeleteButton    = require './delete-button'
PostForm        = require './post-form'
SideMenu        = require './side-menu'
EditBox         = require './edit-box'

FluxMixin       = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin

Article = React.createClass
  mixins : [FluxMixin]

  render : ->
    rawMarkup = marked(@props.children.toString(), {sanitize: true})
    # FIXME : fix animation
    isDeleted = if @props.article.isDeleted then "deleted" else ""
    isHidden  = if @props.article._id? and @props.article.author is @props.username then "" else "hidden"
    # FIXME : fix animation
    <div className="article #{isDeleted}">
      <h1 className="title">{@props.article.title}</h1>
      <PostInformation article={@props.article} />
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
      <div className="article-footer #{isHidden}">
        <DeleteButton article={@props.article} />
        <EditButton article={@props.article} />
      </div>
      <EditBox article={@props.article} />
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


module.exports = Blog
