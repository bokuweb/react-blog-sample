Fluxxor       = require 'fluxxor'
jade          = require 'react-jade'
_             = require 'lodash'
Radium        = require 'radium'
blogStyle     = require './styles/blog'
PostForm      = require './post-form'
SideMenu      = require './side-menu'
Article       = require './article'
ArticleList   = require './article-list'
PostPreview   = require './post-preview'
DeleteModal   = require './delete-modal'

FluxMixin       = Fluxxor.FluxMixin React
StoreWatchMixin = Fluxxor.StoreWatchMixin

Blog = React.createClass
  mixins : [
    FluxMixin
    StoreWatchMixin "ArticlesStore", "ProfileStore", "PostFormStore"
  ]

  getStateFromFlux : ->
    flux = @getFlux()
    {
      articleStore  : flux.store("ArticlesStore").getArticles()
      profileStore  : flux.store("ProfileStore").getState()
      PostFormStore : flux.store("PostFormStore").getState()
    }

  componentDidMount : ->
    @getFlux().actions.article.fetchArticles()

  render : ->
    jade.compile("""
      div(style=blogStyle.container)
        SideMenu(profile=profileStore.profile
                 isProfileFetching=profileStore.isProfileFetching
                 search=articleStore.search)
        div(style=blogStyle.content)
          PostForm(author=profileStore.profile.username
                   title=PostFormStore.title
                   text=PostFormStore.text)
          PostPreview(author=profileStore.profile.username
                      title=PostFormStore.title
                      text=PostFormStore.text)
          div(style=blogStyle.articles)
            ArticleList(articles=articleStore.articles
                        username=profileStore.profile.username)
        DeleteModal(isDeleteModalOpen=articleStore.isDeleteModalOpen
                    deleteId=articleStore.deleteId)
    """)(_.assign {}, @, @state)

module.exports = Radium Blog
