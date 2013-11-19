'use strict'

BaseView = require 'views/base'
SiteTemplate = require 'templates/site'

module.exports = class SiteView extends BaseView

  id: 'site'

  getTemplateFunction: -> SiteTemplate

  regions:
    'content': '.content'
