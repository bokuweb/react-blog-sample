window.React   = require 'react'
Fluxxor        = require 'fluxxor'
ArticlesStore  = require './stores/article-store'
ProfileStore   = require './stores/profile-store'
articleActions = require './actions/articles-actions'
profileActions = require './actions/profile-actions'
Blog           = require './components/blog'

stores =
  ArticlesStore : new ArticlesStore()
  ProfileStore  : new ProfileStore()

actions =
  article : articleActions
  profile : profileActions

flux = new Fluxxor.Flux stores, actions

React.render(
  <Blog flux = {flux} />,
  document.body
)
