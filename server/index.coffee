express = require 'express'
http = require 'http'
path = require 'path'

app = express()

routes = require './routes'


# all environments
app.set "port", process.env.PORT or 3000
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router

# development only
app.use express.errorHandler()  if 'dev' is app.get('env')


# router
app.get '/', routes.index
app.post '/parse', routes.parse


http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
