Fluxxor   = require 'fluxxor'
constants = require '../constants/constants'

ArticlesStore = Fluxxor.createStore
  initialize : ->
    @articles = []
    @bindActions constants.FETCH_ARTICLES, @onFetchArticles
    @bindActions constants.POST_ARTICLE, @onUpdateArticles
    @bindActions constants.DELETE_ARTICLE, @onDeleteArticles

  onFetchArticles : (payload) ->
    @articles = payload.articles
    @emit "change"

  onUpdateArticles : (payload) ->
    return if payload.article.error?
    @articles = [payload.article].concat @articles
    @emit "change"

  onDeleteArticles : (payload) ->
    return if payload.id?
    for article in @articles when article.id is payload.id
      article.isDeleted = true
    @emit "change"

  getArticles : ->
    {articles : @articles}

module.exports = ArticlesStore
