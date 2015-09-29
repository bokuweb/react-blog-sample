constants = require '../constants/constants'
driver    = require '../lib/api-driver'
Q         = require 'q'

module.exports =
  search : (word) ->
    driver.search word
      .then (articles) =>
        @dispatch constants.SEARCH_ARTICLES, {articles : articles, word : word}
      .fail (err) => console.error "/api/v1/search", status, err.toString()



