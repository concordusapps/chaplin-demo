'use strict'

BaseView = require 'views/base'
AboutTemplate = require 'templates/about'

module.exports = class AboutView extends BaseView

  id: 'info'

  getTemplateFunction: -> AboutTemplate
