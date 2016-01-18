
exec = require('child_process').exec

startServer = (params) ->
  app = params.app

  authenticated = (req, res, next) ->
    next()

  app.post '/plugin/shell', authenticated, (req, res) ->
    exec req.body.text, (error, stdout, stderr) ->
      res.send {stdout, stderr}

module.exports = {startServer}