express      = require 'express'
path         = require 'path'
favicon      = require 'serve-favicon'
logger       = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
routes       = require './routes/routes'
config       = require 'config'
ECT          = require 'ect'

app          = express()

app.set 'views', path.join(__dirname, 'views')
app.engine 'ect', ECT({ watch: true, root: __dirname + '/views', ext: '.ect' }).render
app.set 'view engine', 'ect'

# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

routes.configRoutes app

module.exports = app
