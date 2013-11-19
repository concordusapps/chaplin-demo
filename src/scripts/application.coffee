'use strict'

Chaplin = require 'chaplin'

module.exports = class Application extends Chaplin.Application
  # No work 'needs' to be done here; it is left as a point of extension.

  initDispatcher: (options = {}) ->
    # Overriden here to change the controller suffix (which defaults to
    # '-controller' as we have filenames like 'controllers/index' and not
    # 'controllers/index-controller').
    options.controllerSuffix = ''
    super options
