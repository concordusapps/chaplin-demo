'use strict'

Chaplin = require 'chaplin'
SiteView = require 'views/site'
AboutView = require 'views/about'
GettingStartedView = require 'views/getting-started'
GenericInfoView = require 'views/info'

module.exports = class InfoController extends Chaplin.Controller

  beforeAction: ->
    @compose 'site', ->
      @siteView = new SiteView {container: 'body'}
      @siteView.render()

  about: ->
    @model = new Chaplin.Model
      title: 'About'
      text: '
        Chaplin is an architecture for JavaScript applications using the
        Backbone.js library. Chaplin addresses Backbone’s limitations by
        providing a lightweight and flexible structure that features
        well-proven design patterns and best practices.'

    # @view = new AboutView {container: 'body'}
    # @view = new AboutView {region: 'content'}
    @view = new GenericInfoView {region: 'content', @model}
    @view.render()

  started: ->
    @model = new Chaplin.Model
      title: 'Getting Started'
      text: '
        Chaplin empowers you to quickly develop scalable single-page
        web applications; allowing you to focus on designing and
        developing the underlying functionality in your web application.'

    # @view = new AboutView {container: 'body'}
    # @view = new GettingStartedView {region: 'content'}
    @view = new GenericInfoView {region: 'content', @model}
    @view.render()
