'use strict'

Chaplin = require 'chaplin'
moment = require 'moment'

module.exports = class BaseView extends Chaplin.View

  className: 'container'

  getTemplateData: -> _.extend super,
    timestamp: moment().format('h:mm:ss.SSS a')
    id: @cid
