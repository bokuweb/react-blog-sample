mongoose         = require 'mongoose'
Q                = require 'q'
mongooseCachebox = require 'mongoose-cachebox'

options =
  cache : true
  ttl : 240

mongooseCachebox mongoose, options

class DBManager
  constructor : (name, schema) ->
    Schema = mongoose.Schema schema
    @_Model = mongoose.model name, Schema

  save : (doc) ->
    d = Q.defer()
    model = new @_Model doc
    model.save (err, res) ->
      if err
        console.log error
        d.reject()
      else
        d.resolve()
    d.promise

  read : (params = {}) ->
    {page, limit, sort} = params
    limit ?= 10
    page ?= 0
    sort ?= {}
    skip = page * limit
    d = Q.defer()
    @_Model.find {}
      .limit limit
      .sort sort
      .skip skip
      .exec (err, docs) -> d.resolve docs
    d.promise

  findOneById : (id) ->
    d = Q.defer()
    @_Model.findById id, (err, doc) ->
      if err then d.reject err
      else d.resolve doc
    d.promise

  updateById : (id, doc) ->
    d = Q.defer()
    @_Model.findOneAndUpdate {_id : id}, doc
      .exec (err, docs) ->
        if err
          console.log err
          d.reject err
        else
          d.resolve()
    d.promise

  search : (params) ->
    {page, limit, sort, q} = params
    limit ?= 10
    skip = page * limit
    d = Q.defer()
    @_Model.find q
      .limit limit
      .sort sort
      .skip skip
      .exec (err, docs) -> d.resolve docs
    d.promise

  delete : (id) ->
    d = Q.defer()
    @_Model.remove {_id: id}, (err) ->
      if err then d.reject err
      else d.resolve()
    d.promise


    
module.exports = DBManager
