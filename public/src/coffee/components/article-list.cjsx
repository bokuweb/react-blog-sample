jade    = require 'react-jade'
_       = require 'lodash'
Article = require './article'

ArticleList = React.createClass
  render : ->
    if @props.articles.length > 0
      articleNodes = @props.articles.map (article) =>
        jade.compile("""
          Article(article=article key=article._id username=username)= article.text
        """)(_.assign {}, @, @props)
      jade.compile("div=articleNodes")()
    else
      jade.compile("h1 There are yet no article...")()

module.exports = ArticleList
