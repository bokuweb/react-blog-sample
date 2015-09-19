window.React  = require 'react'
Fluxxor       = require 'fluxxor'
ArticlesStore = require './stores/article-store'
actions       = require './actions/articles-actions'
CommentBox    = require './components/main-components'

stores = {ArticlesStore : new ArticlesStore()}
flux = new Fluxxor.Flux stores, actions

React.render(
  <CommentBox flux = {flux} />,
  document.getElementById('content')
)
