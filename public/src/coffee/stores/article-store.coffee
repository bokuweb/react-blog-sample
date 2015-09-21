Fluxxor   = require 'fluxxor'
constants = require '../constants/constants'

ArticlesStore = Fluxxor.createStore
  initialize : ->
    @articles = []
    @bindActions constants.FETCH_ARTICLES, @onFetchArticles
    @bindActions constants.POST_ARTICLE, @onPostArticle
    @bindActions constants.DELETE_ARTICLE, @onDeleteArticle
    @bindActions constants.EDIT_ARTICLE, @onEditArticle
    @bindActions constants.CHANGE_TITLE, @onChangeTitle
    @bindActions constants.CHANGE_TEXT, @onChangeText
    @bindActions constants.UPDATE_ARTICLE, @onUpdateArticle
    
  onFetchArticles : (payload) ->
    @articles = payload.articles
    @emit "change"

  onPostArticle : (payload) ->
    return if payload.article.error?
    @articles = [payload.article].concat @articles
    @emit "change"

  onDeleteArticle : (payload) ->
    return unless payload.id?
    for article, i in @articles when article._id is payload.id
      @articles.splice i , 1
      #article.isDeleted = true
      break
    @emit "change"

  onEditArticle : (payload) ->
    return unless payload.id?
    for article, i in @articles when article._id is payload.id
      if article.isEditing?
        article.isEditing = not article.isEditing
      else
        article.isEditing = true
        article.editingTitle = article.title
        article.editingText = article.text
      break
    @emit "change"

  onChangeTitle : (payload) ->
    return unless payload.id?
    for article, i in @articles when article._id is payload.id
      article.editingTitle = payload.title
      break
    @emit "change"

  onChangeText : (payload) ->
    return unless payload.id?
    for article, i in @articles when article._id is payload.id
      article.editingText = payload.text
      break
    @emit "change"

  onUpdateArticle : (payload) ->
    return unless payload.id?
    for article, i in @articles when article._id is payload.id
      article.isEditing = false
      article.title = payload.article.title
      article.text = payload.article.text
      article.updatedAt = payload.article.updatedAt
      break
    console.dir @articles
    @emit "change"


  getArticles : ->
    {articles : @articles}

module.exports = ArticlesStore
