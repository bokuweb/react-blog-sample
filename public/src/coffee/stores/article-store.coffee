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
    return unless payload.article?
    @articles = [payload.article].concat @articles
    @emit "change"

  getArticles : ->
    {articles : @articles}

module.exports = ArticlesStore
