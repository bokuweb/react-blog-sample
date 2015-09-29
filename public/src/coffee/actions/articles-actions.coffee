constants = require '../constants/constants'
driver    = require '../lib/api-driver'
Q         = require 'q'

module.exports =
  fetchArticles : ->
    driver.fetch()
      .then (articles) =>
        @dispatch constants.FETCH_ARTICLES, {articles : articles}
      .fail (err) => console.error "/api/v1/read", status, err.toString()

  showDeleteModal : (id) ->
    @dispatch constants.SHOW_DELETE_MODAL, {id : id}

  closeDeleteModal : ->
    @dispatch constants.CLOSE_DELETE_MODAL

  deleteArticle : (id) ->
    driver.delete id
      .then (res) =>
        unless res.error?
          @dispatch constants.DELETE_ARTICLE, {id : id}
      .fail (xhr, status, err) ->
        console.error "/api/v1/save", status, err.toString()

  editArticle : (id) ->
    @dispatch constants.EDIT_ARTICLE, {id : id}

  editTitle : (id, title) ->
    @dispatch constants.EDIT_TITLE, {id : id, title : title}

  editText : (id, text) ->
    @dispatch constants.EDIT_TEXT, {id : id, text : text}

  updateArticle : (id, article) ->
    driver.update id, article
      .then (res) =>
        @dispatch constants.UPDATE_ARTICLE, {id : id, article : article}
      .fail (xhr, status, err) ->
        console.error "/api/v1/update", status, err.toString()

