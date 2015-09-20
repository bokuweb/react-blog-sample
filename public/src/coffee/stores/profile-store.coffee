Fluxxor   = require 'fluxxor'
constants = require '../constants/constants'

ProfileStore = Fluxxor.createStore
  initialize : ->
    @profile = {}
    @isFetching = true
    @bindActions constants.FETCH_END_PROFILE, @onFetchProfile

  onFetchProfile : (payload) ->
    @isFetching = false
    @profile = payload.profile
    @emit "change"

  getState : ->
    profile    : @profile
    isFetching : @isFetching

module.exports = ProfileStore
