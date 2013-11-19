'use strict'

BaseView = require 'views/base'
IndexTemplate = require 'templates/index'

module.exports = class IndexView extends BaseView

  id: 'index'

  getTemplateFunction: -> IndexTemplate
