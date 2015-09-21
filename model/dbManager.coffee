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

  getItems : (params) ->
    {page, limit, sort, word, author} = params
    limit ?= 10
    sort ?= {}
    condition = []
    if word?
      word = word.replace(/　/g," ")
      words = word.split " "
      titleCondition = for w in words when w isnt ''
        w = @_pregQuote w
        {title : new RegExp w, "i"}

      if titleCondition.length is 1
        condition.push titleCondition[0]
      else if titleCondition.length > 1
        condition.push {$and : titleCondition}

    if author? and author isnt " "
      author = @_pregQuote author
      condition.push {author : new RegExp author, "i"}

    if store? and store isnt " "
      store = @_pregQuote store
      condition.push {store : new RegExp store, "i"}

    if category? and category isnt " "
      category = @_pregQuote category
      condition.push {category : new RegExp category, "i"}

    condition.push {isEnable : true}
    console.log condition
    if condition.length is 0
      q = {}
    else if condition.length is 1
      q = condition[0]
    else
      q = {$and : condition}

    skip = page * limit
    d = Q.defer()
    @_Model.find q
      #.cache '60s'
      .limit limit
      .sort sort
      .skip skip
      .exec (err, docs) -> d.resolve docs
    d.promise

  delete : (id) ->
    console.log "delete"
    d = Q.defer()
    @_Model.remove {_id: id}, (err) ->
      if err then d.reject err
      else d.resolve()
    d.promise

  getNum : (query = {}) ->
    d = Q.defer()
    @_Model.count query
      .count  (err, count) ->
        if err
          d.reject err
        else
          d.resolve count
    d.promise


  updateTime : (url, date) ->
    d = Q.defer()
    @_Model.findOneAndUpdate {url : url}, {$set: {updatedAt: date, isEnable : true}}, {new: true}
      .exec (err, docs) ->
        if err
          console.log err
          d.reject err
        else
          d.resolve()
    d.promise

# dbdriver
module.exports = DBManager
