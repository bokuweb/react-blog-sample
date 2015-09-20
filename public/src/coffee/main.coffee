window.React   = require 'react'
Fluxxor        = require 'fluxxor'
ArticlesStore  = require './stores/article-store'
ProfileStore   = require './stores/profile-store'
articleActions = require './actions/articles-actions'
profileActions = require './actions/profile-actions'
CommentBox     = require './components/main-components'

stores =
  ArticlesStore : new ArticlesStore()
  ProfileStore  : new ProfileStore()

actions =
  article : articleActions
  profile : profileActions

flux = new Fluxxor.Flux stores, actions

React.render(
  <CommentBox flux = {flux} />,
  document.body
)
