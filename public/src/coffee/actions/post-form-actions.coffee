constants = require '../constants/constants'
Q         = require 'q'

# FIXME : refactor
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
  saveArticle : (article) ->
    # FIXME : refactor
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

  enterTitle : (title) ->
    @dispatch constants.ENTER_TITLE, {title : title}

  enterText : (text) ->
    @dispatch constants.ENTER_TEXT, { text : text}


