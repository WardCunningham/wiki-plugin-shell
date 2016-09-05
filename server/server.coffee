
exec = require('child_process').exec

startServer = (params) ->
  app = params.app
  argv = params.argv

  authorizedAsAdmin = (req, res, next) ->
    if app.securityhandler.isAdmin(req)
      next()
    else
      admin = argv.admin || "undefined"
      user = req.session?.passport?.user || req.session?.email || "unknown"
      res.status(403).send {admin, user}

  app.post '/plugin/shell', authorizedAsAdmin, (req, res) ->
    exec req.body.text, (error, stdout, stderr) ->
      res.send {stdout, stderr}

module.exports = {startServer}
