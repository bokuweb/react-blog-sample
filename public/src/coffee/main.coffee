window.React    = require 'react/addons'
Fluxxor         = require 'fluxxor'
ArticlesStore   = require './stores/article-store'
ProfileStore    = require './stores/profile-store'
PostFormStore   = require './stores/post-form-store'
articleActions  = require './actions/articles-actions'
profileActions  = require './actions/profile-actions'
postFormActions = require './actions/post-form-actions'
Blog            = require './components/blog'

stores =
  ArticlesStore : new ArticlesStore()
  ProfileStore  : new ProfileStore()
  PostFormStore : new PostFormStore()

actions =
  article  : articleActions
  profile  : profileActions
  postForm : postFormActions

flux = new Fluxxor.Flux stores, actions

React.render(
  <Blog flux = {flux} />,
  document.body
)
