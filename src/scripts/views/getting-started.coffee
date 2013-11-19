'use strict'

BaseView = require 'views/base'
GettingStartedTemplate = require 'templates/getting-started'

module.exports = class GettingStartedView extends BaseView

  id: 'info'

  getTemplateFunction: -> GettingStartedTemplate
