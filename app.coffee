express      = require 'express'
path         = require 'path'
favicon      = require 'serve-favicon'
session      = require 'express-session'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
routes       = require './routes/routes'
config       = require 'config'
ECT          = require 'ect'
passport     = require 'passport'
Strategy     = require 'passport-twitter'
  .Strategy

app          = express()

# passport setteng
passport.use new Strategy
    consumerKey    : config.consumerKey
    consumerSecret : config.consumerSecret
    callbackURL    : config.callbackURL
    (token, tokenSecret, profile, done) ->
      process.nextTick -> done null, profile
passport.serializeUser (user, cb) => cb null, user
passport.deserializeUser (obj, cb) => cb null, obj


app.set 'views', path.join(__dirname, 'views')
app.engine 'ect', ECT({ watch: true, root: __dirname + '/views', ext: '.ect' }).render
app.set 'view engine', 'ect'
app.use session
  cookie: { maxAge: 30 * 24 * 60 * 60 * 1000 }
  secret: 'react blog sample!!'
  resave: true
  saveUninitialized: true

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))
app.use passport.initialize()
app.use passport.session()

routes.configRoutes app, passport

module.exports = app
