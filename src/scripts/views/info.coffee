'use strict'

BaseView = require 'views/base'
GenericInfoTemplate = require 'templates/info'

module.exports = class GenericInfoView extends BaseView

  id: 'info'

  getTemplateFunction: -> GenericInfoTemplate
