jade   = require 'react-jade'
_      = require 'lodash'
moment = require "moment"

PostInformation = React.createClass
  render : ->
    avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.article.author}/mini"
    hiddenUnlessUpdated = if @props.article.createdAt is @props.article.updatedAt then "hidden" else ""
    createdAt = "created at #{moment(new Date(@props.article.createdAt)).format('lll')}"
    updatedAt = "updated at #{moment(new Date(@props.article.updatedAt)).format('lll')}"
    jade.compile("""
      .post-infomation
        span.author-name
          img.author-avatar-mini(src=avatarUrl)
          span= article.author
        span.created-at= createdAt
        span.updated-at(class=hiddenUnlessUpdated)= updatedAt
    """)(_.assign {}, @, @props)

module.exports = PostInformation
