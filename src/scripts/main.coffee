'use strict'

require.config
  paths:
    # Plugin to load JS files that have dependencies but aren't wrapped
    # into `define` calls. This is more flexible (and allows for configuration
    # before exporting into the global scope) than the standard shim config.
    depend: 'vendor/require-depend'

    # A utility-belt library for JavaScript that provides a lot of the
    # functional programming support.
    # http://underscorejs.org/
    # underscore: 'components/underscore'
    underscore: 'lib/underscore'

    # Core of underscore, utility manipulation library.
    'underscore-core': '../components/scripts/underscore/underscore'

    # String manipulation extensions for underscore.
    'underscore-string':
      '../components/scripts/underscore.string/underscore.string'

    # jQuery is a fast, small, and feature-rich JavaScript library. It makes
    # things like HTML document traversal and manipulation, event handling,
    # animation, and Ajax much simpler with an easy-to-use API that works
    # across a multitude of browsers.
    # http://api.jquery.com/
    # jquery: 'components/jquery'
    jquery: 'lib/jquery'

    # Core DOM manipulation library.
    'jquery-core': '../components/scripts/jquery/jquery'

    # Set of specific UI extensions to jQuery.
    # Currently; we are only grabbing the position API.
    'jquery-ui': 'vendor/jquery-ui'

    # Set of extensions and customizations for moment.js.
    moment: 'lib/moment'

    # Moment js, for date/time formatting
    'moment-core': '../components/scripts/moment/moment'

    # Provides the JSON object for manipulation of JSON strings if not
    # already defined. This is required for support of IE 8 and below.
    # http://bestiejs.github.com/json3/
    json2: '../components/scripts/json3/json3'

    # Backbone.js gives structure to web applications by providing models with
    # key-value binding and custom events, collections with a rich API of
    # enumerable functions, views with declarative event handling, and connects
    # it all to your existing API over a RESTful JSON interface.
    # backbone: 'components/backbone'
    backbone: 'lib/backbone'

    # Set of components and conventions powering Chaplin.
    'backbone-core': '../components/scripts/backbone/backbone'

    # Data binding utility library on top of backbone.
    'backbone-stickit':
      '../components/scripts/backbone.stickit/backbone.stickit'

    # Bootstrap (and plugins).
    bootstrap: '../components/scripts/bootstrap-sass/bootstrap'

    # Haml (HTML abstraction markup language) is based on one primary
    # principle: markup should be beautiful.
    # https://github.com/netzpirat/haml-coffee
    haml: 'lib/haml'

    # Directory containing the micro-templates.
    # This is needed as templates are required as 'templates/...' but the
    # template directory lives at 'src/templates/...' and not
    # 'src/scripts/templates...'.
    templates: '../templates'

    # Chaplin.js; Web application framework on top of Backbone.js.
    chaplin: '../components/scripts/chaplin/chaplin'

  shim:

    'backbone-core':
      exports: 'Backbone'
      deps: [
        'jquery'
        'underscore'
      ]

    'backbone-stickit': ['backbone-core']

    bootstrap:
      deps: ['jquery-core']
      exports: '$'

    'jquery-ui':
      deps: [ 'jquery-core' ]
      exports: '$'

    'moment-core':
      exports: 'moment'

    'underscore-string':
      exports: '_.str'

    'underscore-core':
      exports: '_'


#! Instantiate the application and begin the execution cycle.
require ['app'], (Application) ->
  app = new Application()
  app.initialize()
