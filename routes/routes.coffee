express        = require 'express'
mongoose       = require 'mongoose'
config         = require 'config'
DBManager      = require '../model/dbManager'

router   = express.Router()

if process.env.OPENSHIFT_MONGODB_DB_URL?
  mongoURL = process.env.OPENSHIFT_MONGODB_DB_URL + process.env.OPENSHIFT_APP_NAME
else
  mongoURL = "mongodb://localhost:27017/reactBlog"

mongoose.connect mongoURL
process.on 'SIGINT', ->
  mongoose.connection.close ->
    console.log 'Mongoose disconnected on app termination'
    process.exit 0

articleDB = new DBManager 'blog',
  #id          : Number
  title       : String
  text        : String
  author      : String
  createdAt   : Date
  updatedAt   : Date

configRoutes = (app, passport) ->
  app.get '/', (req, res) ->
    console.dir req.user
    res.render 'index', {}

  app.post '/api/v1/save', (req, res) ->
    console.dir req.body
    articleDB.save req.body
    res.json req.body

  app.post '/api/v1/delete/:id', (req, res) ->
    # TODO : auth
    # retrun unless req.session.passport.user
    {id} = req.params
    return unless id
    articleDB.delete id
    res.json req.body

  app.get '/api/v1/read', (req, res) ->
    articleDB.read()
      .then (docs) =>
        console.log docs
        res.json docs

  app.get '/api/v1/profile', (req, res) ->
    if req.session?.passport?.user?
      res.json req
    else
      res.json {error : "not authenticated"}

  app.get '/login', passport.authenticate('twitter')

  app.get '/login/callback', passport.authenticate('twitter',
      successRedirect: '/'
      failureRedirect: '/'
  )

  app.get '/logout', (req, res) ->
    req.session.destroy()
    req.logout()
    res.redirect('/')

  # development error handler
  # will print stacktrace
  if app.get 'env' is 'development'
    app.use (err, req, res, next) ->
      res.status err.status or 500
      res.render 'error',
        message: err.message
        error: err
      return

  # catch 404 and forward to error handler
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message : err.message
      error : {}

module.exports = {configRoutes : configRoutes}
