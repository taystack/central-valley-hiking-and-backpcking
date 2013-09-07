'use strict'

View = require 'lib/views/view'
Template = require 'templates/about'

module.exports = class About extends View

  template: Template

  id: 'about'

  events:
    # Keep picasa api from routing us away.
    'click .image a': (event) ->
      event.preventDefault()
