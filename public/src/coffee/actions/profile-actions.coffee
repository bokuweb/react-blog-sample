constants = require '../constants/constants'
driver    = require '../lib/api-driver'

module.exports =
  fetchProfile : ->
    driver.profile()
      .then (profile) =>
        @dispatch constants.FETCH_END_PROFILE, {profile : profile}
      .fail (xhr, status, err) =>
        console.error "/api/v1/profile", status, err.toString()
