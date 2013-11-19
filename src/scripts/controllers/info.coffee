'use strict'

Chaplin = require 'chaplin'
SiteView = require 'views/site'
AboutView = require 'views/about'
GettingStartedView = require 'views/getting-started'

module.exports = class InfoController extends Chaplin.Controller

  beforeAction: ->
    @compose 'site', ->
      @siteView = new SiteView {container: 'body'}
      @siteView.render()

  about: ->
    @view = new AboutView {region: 'content'}
    @view.render()

  started: ->
    @view = new GettingStartedView {region: 'content'}
    @view.render()
