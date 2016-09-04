
exec = require('child_process').exec

startServer = (params) ->
  app = params.app
  argv = params.argv

  authorizedAsAdmin = (req, res, next) ->
    if app.securityhandler.isAdmin(req)
      next()
    else
      console.log 'rejecting', req.path
      res.status(403).send {admin: argv.admin || "undefined", user: req.session?.passport?.user || "unknown"}

  app.post '/plugin/shell', authorizedAsAdmin, (req, res) ->
    exec req.body.text, (error, stdout, stderr) ->
      res.send {stdout, stderr}

module.exports = {startServer}
