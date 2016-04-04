# vim: set expandtab tabstop=2 shiftwidth=2 softtabstop=2
log = (x...) -> try console.log x...

_ = require 'lodash'

fs = require 'fs'
mime = require 'mime'

module.exports = b64_image = {

  convert: (file) ->
    if !fs.statSync(file)
      throw new Error "File does not exist"

    bulk = fs.readFileSync(file).toString 'base64'
    ('data:' + require('mime').lookup(file) + ';base64,' + bulk)

  # parse cli
  run: ->
    cli = process.argv.slice 2

    if !cli.length or cli.join(' ').match 'help'
      log("Usage ./ <file>")
      process.exit 0

    log @convert cli.shift()
    process.exit 0
}

##
if process.env.TAKY_DEV
  log /TAKY_DEV/
  log b64_image.convert __dirname + '/test/google.png'

