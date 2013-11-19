'use strict'

Chaplin = require 'chaplin'
moment = require 'moment'

module.exports = class BaseView extends Chaplin.View

  className: 'container'

  getTemplateData: ->
    timestamp: moment().format('dddd, MMMM Do YYYY, h:mm:ss.SSS a')
    id: @cid
