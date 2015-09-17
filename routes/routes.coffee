express        = require 'express'
mongoose       = require 'mongoose'
config         = require 'config'

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

###
ebooksDB = new EbookDBManager 'ebook',
  title       : String
  author      : String
  url         : String
  #node        : String
  category    : String
  #isbn        : String
  store       : String
  createdAt   : Date
  updatedAt   : Date
  #hasLimit    : Boolean # 期間限定商品?
  canDownload : Boolean
  isEnable    : Boolean
  image       :
    small  : String
    medium : String
    large  : String

scheduler = new CrawlScheduler ebooksDB
scheduler.start()
###

configRoutes = (app) ->
  app.get '/', (req, res, next) ->
    res.render 'index', {}

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
