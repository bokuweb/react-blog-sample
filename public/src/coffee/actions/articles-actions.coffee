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

  deleteArticle : (id) ->
    console.log id
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

