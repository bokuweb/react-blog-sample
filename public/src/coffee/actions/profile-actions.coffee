constants = require '../constants/constants'

module.exports =
  fetchProfile : ->
    $.ajax
      url: "/api/v1/profile"
      dataType: 'json'
      cache: false
      success: (profile) =>
        console.dir profile
        @dispatch constants.FETCH_PROFILE, {profile : profile}
      error : (xhr, status, err) =>
        console.error "/api/v1/profile", status, err.toString()
