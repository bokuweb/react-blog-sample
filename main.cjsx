React = require 'react'

Comment = React.createClass
  render : ->
    rawMarkup = marked(@props.children.toString(), {sanitize: true})
    <div className="comment">
      <h2 className="commentAuthor">
        {@props.author}
      </h2>
      <span dangerouslySetInnerHTML={{__html: rawMarkup}} />
    </div>

CommentList = React.createClass
  render : ->
    commentNodes = @props.data.map (comment) ->
      <Comment author={comment.author}>
        {comment.text}
      </Comment>

    <div className="commentList">
      {commentNodes}
    </div>

CommentForm = React.createClass
  handleSubmit : (e) ->
    e.preventDefault()
    title = React.findDOMNode(@refs.title).value.trim()
    author = React.findDOMNode(@refs.author).value.trim()
    text = React.findDOMNode(@refs.text).value.trim()
    return if not text or not author
    @props.onCommentSubmit
      title : title
      author: author
      text: text
      createdAt : new Date()
      updatedAt : new Date()

    React.findDOMNode(@refs.title).value = ''
    React.findDOMNode(@refs.author).value = ''
    React.findDOMNode(@refs.text).value = ''
    return

  render : ->
    <form className="commentForm" onSubmit={@handleSubmit}>
      <input type="text" placeholder="Say something..." ref="title" />
      <input type="text" placeholder="Your name" ref="author" />
      <input type="text" placeholder="Say something..." ref="text" />
      <input type="submit" value="Post" />
    </form>

CommentBox = React.createClass
  loadCommentsFromServer : ->
    $.ajax
      url: @props.url
      dataType: 'json'
      cache: false
      success: (data) =>
        console.dir data
        @setState {data: data}
      error : (xhr, status, err) =>
        console.error @props.url, status, err.toString()

  handleCommentSubmit : (article) ->
    articles = @state.data
    newArticles = articles.concat [article]
    @setState {data: newArticles}
    $.ajax
      url: "/api/v1/save"
      dataType: 'json'
      type: 'POST'
      data: article
      #success: (data) ->
      #  @setState {data: data}
      error : (xhr, status, err) ->
        console.error(@props.url, status, err.toString())

  getInitialState : -> {data: []}

  componentDidMount : ->
    @loadCommentsFromServer()
    setInterval this.loadCommentsFromServer, @props.pollInterval

  render : ->
    <div className="commentBox">
      <h1>Comments</h1>
        <CommentList data={@state.data} />
        <CommentForm onCommentSubmit={@handleCommentSubmit} />
    </div>

React.render(
  <CommentBox url="/api/v1/read" pollInterval={5000} />,
  document.getElementById('content')
)

