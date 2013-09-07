'use strict'

Chaplin = require 'chaplin'

module.exports = class View extends Chaplin.View

  template: require 'templates/index'

  getTemplateFunction: -> @template

  container: '#container'

  render: ->
    super

    if @model
      bindings = {}
      for binding in Chaplin.utils.getAllPropertyVersions this, 'bindings'
        for key, value of binding
          bindings[key] = value

      @stickit @model, bindings

    for name, subview of @subviewsByName
      subview.render()

      subview.delegateEvents() if _.isFunction subview.delegateEvents

    return

  dispose: ->
    return if @disposed
    @unstickModel()
    super
