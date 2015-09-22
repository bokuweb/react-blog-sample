moment = require "moment"

class PostInformation extends React.Component
  render : ->
    avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.article.author}/mini"
    hiddenUnlessUpdated = if @props.article.createdAt is @props.article.updatedAt then "hidden" else ""
    createdAt = moment(new Date(@props.article.createdAt)).format('lll')
    updatedAt = moment(new Date(@props.article.updatedAt)).format('lll')
    <div className="post-infomation">
      <span className="author-name">
        <img src={avatarUrl} className="author-avatar-mini"/>
        {@props.article.author}
      </span>
      <span className="created-at">created at {createdAt}</span>
      <span className="updated-at #{hiddenUnlessUpdated}">updated at {updatedAt}</span>
    </div>

module.exports = PostInformation
