Fluxxor   = require 'fluxxor'
constants = require '../constants/constants'

ArticlesStore = Fluxxor.createStore
  initialize : ->
    @articles = []
    @bindActions constants.FETCH_ARTICLES, @onFetchArticles
    @bindActions constants.POST_ARTICLE, @onUpdateArticles

  onFetchArticles : (payload) ->
    @articles = payload.articles
    @emit "change"

  onUpdateArticles : (payload) ->
    @articles = [payload.article].concat @articles
    @emit "change"

  getState : ->
    {articles : @articles}

module.exports = ArticlesStore