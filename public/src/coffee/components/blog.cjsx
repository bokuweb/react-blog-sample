Fluxxor     = require 'fluxxor'
jade        = require 'react-jade'
_           = require 'lodash'
Radium      = require 'radium'
blogStyle   = require './styles/blog'
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
      div(style=blogStyle.container)
        SideMenu(profile=profileStore.profile
                 isProfileFetching=profileStore.isProfileFetching)
        div(style=blogStyle.content)
          PostForm(author=profileStore.profile.username)
          div(style=blogStyle.articles)
            ArticleList(articles=articleStore.articles
                        username=profileStore.profile.username)
    """)(_.assign {}, @, @state)

module.exports = Radium Blog
