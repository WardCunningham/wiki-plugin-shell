
exec = require('child_process').exec

startServer = (params) ->
  app = params.app

  authorized = (req, res, next) ->
    if app.securityhandler.isAuthorized(req)
      next()
    else
      console.log 'rejecting', req.path
      res.sendStatus(403)

  app.post '/plugin/shell', authorized, (req, res) ->
    exec req.body.text, (error, stdout, stderr) ->
      res.send {stdout, stderr}

module.exports = {startServer}
