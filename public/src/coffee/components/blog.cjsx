Fluxxor     = require 'fluxxor'
jade        = require 'react-jade'
_           = require 'lodash'
Radium      = require 'radium'
Modal       = require 'react-modal'
blogStyle   = require './styles/blog'
PostForm    = require './post-form'
SideMenu    = require './side-menu'
Article     = require './article'
ArticleList = require './article-list'
modalStyles = require './styles/modal'

FluxMixin       = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin


Blog = React.createClass
  mixins : [
    FluxMixin
    StoreWatchMixin "ArticlesStore", "ProfileStore"
  ]

  getStateFromFlux : ->
    flux = @getFlux()
    {
      articleStore : flux.store("ArticlesStore").getArticles()
      profileStore : flux.store("ProfileStore").getState()
    }

  componentDidMount : ->
    @getFlux().actions.article.fetchArticles()

  closeDeleteModal : ->
    @getFlux().actions.article.closeDeleteModal()

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
        Modal(
          isOpen=articleStore.isDeleteModalOpen
          onRequestClose=closeDeleteModal
          style=modalStyles)
          span delete this post, really ok?
    """)(_.assign {}, @, @state)

module.exports = Radium Blog
