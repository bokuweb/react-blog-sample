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

blogDB = new DBManager 'blog',
  #id          : Number
  title       : String
  text        : String
  author      : String
  createdAt   : Date
  updatedAt   : Date

configRoutes = (app, passport) ->
  app.get '/', (req, res) ->
    res.render 'index', {}

  app.post '/api/v1/save', (req, res) ->
    console.dir req.body
    blogDB.save req.body
    #res.render 'index', {}
    res.json req.body

  app.post '/api/v1/delete/:id', (req, res) ->
    # retrun unless req.user
    {id} = req.params
    return unless id
    blogDB.delete id
    #res.render 'index', {}
    res.json req.body

  app.get '/api/v1/read', (req, res) ->
    blogDB.read()
      .then (docs) =>
        console.log docs
        res.json docs

  app.get '/login', passport.authenticate('twitter')

  app.get '/login/return',
    passport.authenticate 'twitter', { failureRedirect: '/login' },
    (req, res) =>
      res.redirect('/')

  app.get '/profile',
    require('connect-ensure-login').ensureLoggedIn(),
    (req, res) =>
      res.render 'profile', { user: req.user }

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
