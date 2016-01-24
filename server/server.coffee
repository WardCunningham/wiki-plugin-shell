
exec = require('child_process').exec

startServer = (params) ->
  app = params.app

  authorizedAsAdmin = (req, res, next) ->
    if app.securityhandler.isAdmin(req)
      next()
    else
      console.log 'rejecting', req.path
      res.sendStatus(403)

  app.post '/plugin/shell', authorizedAsAdmin, (req, res) ->
    exec req.body.text, (error, stdout, stderr) ->
      res.send {stdout, stderr}

module.exports = {startServer}
