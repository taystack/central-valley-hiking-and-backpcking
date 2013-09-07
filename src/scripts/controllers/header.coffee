'use strict'

Chaplin = require 'chaplin'
Controller = require 'lib/controllers/controller'
Model = require 'lib/models/model'

View =
  Header: require 'views/header'

module.exports = class Index extends Controller

  beforeAction:
    '.*': ->
      @compose 'header',
        compose: ->
          composition = {}
          composition.model = new Chaplin.Model {
            links: {
              Home: '/home'
              Activities: '/activities'
              About: '/about'
              Photos: '/photos'
            }
          }
          composition.view = new View.Header
            model: composition.model
          composition.view.render()
          composition
