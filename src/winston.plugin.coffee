winston = require 'winston'

winstonConfig =
  levels:
    error: 6
    err: 6
    warn: 6
    info: 6
    notify: 6
  colors:
    emergency: 'red'
    alert: 'red'
    critical: 'red'
    error: 'red'
    warning: 'yellow'
    notice: 'yellow'
    info: 'green'
    debug: 'green'
    emerg: 'red'
    crit: 'red'
    err: 'red'
    warn: 'yellow'
    note: 'yellow'

module.exports = (BasePlugin) ->

  class WinstonPlugin extends BasePlugin

    name: 'winston'

    docpadLoaded: (opts) ->
      docpad = @docpad

      logger = new (winston.Logger)(
        levels: winstonConfig.levels
        transports: [
          new (winston.transports.Console)(
            colorize: true
          )
        ]
      )
      winston.addColors winstonConfig.colors

      docpad.log = (type, msg, err) ->
        logger.log type, msg
        if type is 'err'
          logger.log type, err

      @
