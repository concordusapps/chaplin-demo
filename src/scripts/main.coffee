'use strict'

require.config
  baseUrl: '/scripts'
  paths:
    # jQuery
    # <http://jquery.com/>
    jquery: '../bower_components/jquery/jquery'

    # Lo-Dash
    # <http://lodash.com/>
    underscore: '../bower_components/lodash/dist/lodash.compat'

    # Moment.js
    # <http://momentjs.com/>
    moment: '../bower_components/moment/moment'

    # Chaplin.js
    # <http://chaplinjs.org/>
    chaplin: '../bower_components/chaplin/chaplin'

    # Exoskeleton.js
    # <http://exosjs.com/>
    backbone: '../bower_components/exoskeleton/exoskeleton'

require [ 'application', 'routes' ], (Application, routes) ->
  application = new Application
    routes: routes

    # Overriden here to change the controller suffix (which defaults to
    # '_controller' as we have filenames like 'controllers/index' and not
    # 'controllers/index_controller').
    controllerSuffix: ''
