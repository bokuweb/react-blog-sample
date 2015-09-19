express      = require 'express'
path         = require 'path'
favicon      = require 'serve-favicon'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
routes       = require './routes/routes'
config       = require 'config'
ECT          = require 'ect'
passport     = require 'passport'
session      = require 'express-session'
Strategy     = require 'passport-twitter'
  .Strategy

app          = express()

passport.use new Strategy
    consumerKey : process.env.CONSUMER_KEY
    consumerSecret : process.env.CONSUMER_SECRET
    callbackURL : 'http://127.0.0.1:3000/login/return'
  (token, tokenSecret, profile, cb) =>
    cb null, profile

passport.serializeUser (user, cb) => cb null, user

passport.deserializeUser (obj, cb) => cb null, obj

app.use passport.initialize()

app.use passport.session()

app.set 'views', path.join(__dirname, 'views')
app.engine 'ect', ECT({ watch: true, root: __dirname + '/views', ext: '.ect' }).render
app.set 'view engine', 'ect'
app.use session
  secret: 'keyboard cat'
  resave: true
  saveUninitialized: true

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

routes.configRoutes app, paassport

module.exports = app
