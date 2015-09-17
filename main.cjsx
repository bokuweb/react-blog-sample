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
    author = React.findDOMNode(@refs.author).value.trim()
    text = React.findDOMNode(@refs.text).value.trim()
    return if not text or not author

    @props.onCommentSubmit {author: author, text: text}
    React.findDOMNode(@refs.author).value = ''
    React.findDOMNode(@refs.text).value = ''
    return

  render : ->
    <form className="commentForm" onSubmit={@handleSubmit}>
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

  handleCommentSubmit : (comment) ->
    comments = @state.data
    newComments = comments.concat [comment]
    @setState {data: newComments}
    $.ajax
      url: @props.url
      dataType: 'json'
      type: 'POST'
      data: comment
      success: (data) ->
        @setState {data: data}
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
  <CommentBox url="http://127.0.0.1:8080/comments.json" pollInterval={5000} />,
  document.getElementById('content')
)

