'use strict'

View = require 'lib/views/view'
Template = require 'templates/photos'

module.exports = class Photos extends View

  template: Template

  id: 'photos'

  events:
    'click embed': (event) ->
      event.preventDefault()
