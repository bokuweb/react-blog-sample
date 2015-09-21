constants = require '../constants/constants'

module.exports =
  fetchProfile : ->
    #@dispatch constants.FETCH_START_PROFILE, {profile : profile}
    $.ajax
      url: "/api/v1/profile"
      dataType: 'json'
      cache: false
      success: (profile) =>
        @dispatch constants.FETCH_END_PROFILE, {profile : profile}
      error : (xhr, status, err) =>
        console.error "/api/v1/profile", status, err.toString()
