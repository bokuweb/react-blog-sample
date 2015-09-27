constants = require '../constants/constants'
Q         = require 'q'

# FIXME : refactor
# move to API lib
_search = (word) ->
  d = Q.defer()
  $.ajax
    url: "/api/v1/search/0/#{word}"
    dataType: 'json'
    cache: false
    success: (articles) => d.resolve articles
    error : (xhr, status, err) => d.reject err
  d.promise

module.exports =
  search : (word) ->
    _search word
      .then (articles) =>
        @dispatch constants.SEARCH_ARTICLES, {articles : articles, word : word}
      .fail (err) => console.error "/api/v1/search", status, err.toString()



