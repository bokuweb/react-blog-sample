constants = require '../constants/constants'
driver    = require '../lib/api-driver'
Q         = require 'q'

module.exports =
  saveArticle : (article) ->
    driver.save article
      .then (article) =>
        @dispatch constants.POST_ARTICLE, {article : article}
        driver.fetch().then (articles) =>
          @dispatch constants.FETCH_ARTICLES, {articles : articles}
      .fail (xhr, status, err) ->
        console.error "/api/v1/save", status, err.toString()

  enterTitle : (title) ->
    @dispatch constants.ENTER_TITLE, {title : title}

  enterText : (text) ->
    @dispatch constants.ENTER_TEXT, { text : text}


