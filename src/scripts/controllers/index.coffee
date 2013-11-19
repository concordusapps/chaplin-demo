'use strict'

Chaplin = require 'chaplin'
IndexView = require 'views/index'

module.exports = class IndexController extends Chaplin.Controller

  show: ->
    @view = new IndexView {container: 'body'}
    @view.render()
