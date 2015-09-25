constants = require '../constants/constants'
Q         = require 'q'

_fetch = ->
  d = Q.defer()
  $.ajax
    url: "/api/v1/read"
    dataType: 'json'
    cache: false
    success: (articles) => d.resolve articles
    error : (xhr, status, err) => d.reject err
  d.promise

module.exports =
  fetchArticles : ->
    _fetch()
      .then (articles) =>
        @dispatch constants.FETCH_ARTICLES, {articles : articles}
      .fail (err) => console.error "/api/v1/read", status, err.toString()

  saveArticle : (article) ->
    $.ajax
      url: "/api/v1/save"
      dataType: 'json'
      type: 'POST'
      data: article
      success: (article) =>
        @dispatch constants.POST_ARTICLE, {article : article}
        _fetch().then (articles) =>
          @dispatch constants.FETCH_ARTICLES, {articles : articles}
      error : (xhr, status, err) ->
        console.error "/api/v1/save", status, err.toString()

  showDeleteModal : (id) ->
    @dispatch constants.SHOW_DELETE_MODAL, {id : id}

  closeDeleteModal : ->
    @dispatch constants.CLOSE_DELETE_MODAL
    
  deleteArticle : (id) ->
    $.ajax
      url: "/api/v1/delete"
      dataType: 'json'
      type: 'POST'
      data: {id : id}
      success: (res) =>
        unless res.error?
          @dispatch constants.DELETE_ARTICLE, {id : id}
      error : (xhr, status, err) ->
        console.error "/api/v1/save", status, err.toString()

  editArticle : (id) ->
    @dispatch constants.EDIT_ARTICLE, {id : id}

  editTitle : (id, title) ->
    @dispatch constants.EDIT_TITLE, {id : id, title : title}

  editText : (id, text) ->
    @dispatch constants.EDIT_TEXT, {id : id, text : text}

  updateArticle : (id, article) ->
    $.ajax
      url: "/api/v1/update"
      dataType: 'json'
      type: 'POST'
      data: article
      success: (res) =>
        @dispatch constants.UPDATE_ARTICLE, {id : id, article : article}
      error : (xhr, status, err) ->
        console.error "/api/v1/update", status, err.toString()

