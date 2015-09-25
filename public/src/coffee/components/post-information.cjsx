jade                 = require 'react-jade'
_                    = require 'lodash'
moment               = require 'moment'
Radium               = require 'radium'
postInformationStyle = require './styles/post-information'
commonStyle          = require './styles/common'

PostInformation = React.createClass
  render : ->
    avatarUrl = "http://gadgtwit.appspot.com/twicon/#{@props.article.author}/mini"
    updatedAtStyle = if @props.article.createdAt is @props.article.updatedAt
      commonStyle.hidden
    else
      postInformationStyle.text
    createdAt = "created at #{moment(new Date(@props.article.createdAt)).format('lll')}"
    updatedAt = "updated at #{moment(new Date(@props.article.updatedAt)).format('lll')}"
    jade.compile("""
      .post-infomation
        span(style=postInformationStyle.text)
          img(src=avatarUrl style=postInformationStyle.avatar)
          span= article.author
        span(style=postInformationStyle.text)= createdAt
        span(style=updatedAtStyle)= updatedAt
    """)(_.assign {}, @, @props)

module.exports = Radium PostInformation
