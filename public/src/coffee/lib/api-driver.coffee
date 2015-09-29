Q = require 'q'
$ = require 'jquery'

module.exports =
  fetch : ->
    d = Q.defer()
    $.ajax
      url: "/api/v1/read"
      dataType: 'json'
      cache: false
      success: (articles) => d.resolve articles
      error : (xhr, status, err) => d.reject err
    d.promise

  save : (article) ->
    d = Q.defer()
    $.ajax
      url: "/api/v1/save"
      dataType: 'json'
      type: 'POST'
      data: article
      success: => d.resolve article
      error : (xhr, status, err) ->
        console.error "/api/v1/save", status, err.toString()
    d.promise

  delete : (id) ->
    d = Q.defer()
    $.ajax
      url: "/api/v1/delete"
      dataType: 'json'
      type: 'POST'
      data: {id : id}
      success: (res) =>
        if res.error?
          d.reject res.error
        else
          d.resolve {id : id}
      error : (xhr, status, err) ->
        console.error "/api/v1/delete", status, err.toString()

  update : (id, article) ->
    d = Q.defer()
    $.ajax
      url: "/api/v1/update"
      dataType: 'json'
      type: 'POST'
      data: article
      success: (res) =>
        d.resolve {id : id, article : article}
      error : (xhr, status, err) ->
        console.error "/api/v1/update", status, err.toString()
    d.promise

  search : (word) ->
    d = Q.defer()
    $.ajax
      url: "/api/v1/search/0/#{word}"
      dataType: 'json'
      cache: false
      success: (articles) => d.resolve articles
      error : (xhr, status, err) => d.reject err
    d.promise

  profile : ->
    d = Q.defer()
    $.ajax
      url: "/api/v1/profile"
      dataType: 'json'
      cache: false
      success: (profile) => d.resolve profile
      error : (xhr, status, err) =>  d.reject err
    d.promise
