Fluxxor   = require 'fluxxor'
constants = require '../constants/constants'

ProfileStore = Fluxxor.createStore
  initialize : ->
    @profile = {}
    @bindActions constants.FETCH_PROFILE, @onFetchProfile

  onFetchProfile : (payload) ->
    @profile = payload.profile
    @emit "change"

  getState : ->
    {profile : @profile}

module.exports = ProfileStore
