Fluxxor   = require 'fluxxor'
constants = require '../constants/constants'

PostFormStore = Fluxxor.createStore
  initialize : ->
    @title = ""
    @text = ""
    @bindActions constants.ENTER_TEXT, @onEnterText
    @bindActions constants.ENTER_TITLE, @onEnterTitle
    @bindActions constants.POST_ARTICLE, @onPostArticle

  onPostArticle : ->
    @title = ""
    @text = ""

  onEnterTitle : (payload) ->
    @title = payload.title
    @emit "change"

  onEnterText : (payload) ->
    @text = payload.text
    @emit "change"

  getState : ->
    text : @text
    title : @title

module.exports = PostFormStore
