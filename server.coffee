fs = require 'fs'
path = require 'path'
{print} = require 'util'
{spawn} = require 'child_process'

express = require 'express'
Hercules = require 'hercules'

clientDir = path.join(__dirname, 'client')

coffee = spawn 'coffee', ['-c', '-o', path.join(clientDir, 'lib'), path.join(clientDir, 'src')]

coffee.stderr.on 'data', (data) -> process.stderr.write data.toString()
coffee.stdout.on 'data', (data) -> print data.toString()

coffee.on 'exit', ->
  bundle = Hercules.bundle clientDir
  app = express.createServer()
  app.get '/application.js', (request, response) ->
    response.send bundle.toString()
  app.use express.static path.join clientDir, 'static'
  app.listen 3000
  console.log "Gravity listening on port 3000"
