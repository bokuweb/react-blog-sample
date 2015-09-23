Fluxxor     = require 'fluxxor'
jade        = require 'react-jade'
_           = require 'lodash'
PostForm    = require './post-form'
SideMenu    = require './side-menu'
Article     = require './article'
ArticleList = require './article-list'

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
    jade.compile("""
      #container
        SideMenu(profile=profileStore.profile
                 isProfileFetching=profileStore.isProfileFetching)
        #content
          PostForm(author=profileStore.profile.username)
          #articles
            ArticleList(articles=articleStore.articles
                        username=profileStore.profile.username)
    """)(_.assign {}, @, @state)

module.exports = Blog
