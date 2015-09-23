Article = require './article'

ArticleList = React.createClass
  render : ->
    if @props.articles.length > 0
      articleNodes = @props.articles.map (article) =>
        <Article article = {article}
                 key = {article._id}
                 username = {@props.username} >
          {article.text}
        </Article>
      <div>{articleNodes}</div>
    else
      <h1>There are yet no article...</h1>

module.exports = ArticleList
