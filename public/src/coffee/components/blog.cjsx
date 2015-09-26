Fluxxor       = require 'fluxxor'
jade          = require 'react-jade'
_             = require 'lodash'
Radium        = require 'radium'
Modal         = require 'react-modal'
blogStyle     = require './styles/blog'
PostForm      = require './post-form'
SideMenu      = require './side-menu'
Article       = require './article'
ArticleList   = require './article-list'
modalStyles   = require './styles/modal'
deleteOkStyle = require './styles/delete-ok-button'
SmallButton   = require './small-button'
PostPreview   = require './post-preview'

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

  closeDeleteModal : ->
    @getFlux().actions.article.closeDeleteModal()

  handleDeleteOkClick : ->
    @getFlux().actions.article.deleteArticle @state.articleStore.deleteId

  handleDeleteCancelClick : ->
    @getFlux().actions.article.closeDeleteModal()

  render : ->
    # FIXME : refactor
    jade.compile("""
      div(style=blogStyle.container)
        SideMenu(profile=profileStore.profile
                 isProfileFetching=profileStore.isProfileFetching)
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
        Modal(
          isOpen=articleStore.isDeleteModalOpen
          onRequestClose=closeDeleteModal
          style=modalStyles)
          span delete this post, really ok?
          br
          SmallButton(
            buttonText="Ok"
            handleClick=handleDeleteOkClick
            buttonStyle=deleteOkStyle
          )
          SmallButton(
            buttonText="Cancel"
            handleClick=handleDeleteCancelClick
            buttonStyle=deleteOkStyle
          )

    """)(_.assign {}, @, @state)

module.exports = Radium Blog
