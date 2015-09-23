Fluxxor         = require 'fluxxor'
PostForm        = require './post-form'
SideMenu        = require './side-menu'
Article         = require './article'
ArticleList     = require './article-list'

FluxMixin       = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin

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
      <SideMenu
        profile = {@state.profileStore.profile},
        isProfileFetching = {@state.profileStore.isProfileFetching} />
      <div id = "content">
        <PostForm author = {@state.profileStore.profile.username}/>
        <div id = "articles">
          <ArticleList articles = {@state.articleStore.articles},
                       username = {@state.profileStore.profile.username} />
        </div>
      </div>
    </div>


module.exports = Blog
