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
    return unless payload.id?
    for article, i in @articles when article._id is payload.id
      @articles.splice i , 1
      #article.isDeleted = true
      break
    @emit "change"

  getArticles : ->
    {articles : @articles}

module.exports = ArticlesStore
