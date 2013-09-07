'use strict'

$ = require 'jquery'
View = require 'lib/views/view'

Templates =
  Header: require 'templates/header/menu'
  Links: require 'templates/header/links'

module.exports = class Menu extends View

  template: Templates.Header

  id: 'header'

  bindings:
    '#menu-links':
      observe: 'links'
      updateMethod: 'html'
      escape: false
      onGet: Templates.Links

  events:
    'click .icon-reorder': ->
      @$('#menu-links').slideToggle 200 if @$('#mobile').is ':visible'

    'click #menu-links a': ->
      @$('#menu-links').slideToggle 200 if @$('#mobile').is ':visible'


  regions:
    '#body': 'body'

  container: '#container'

  render: ->
    super
    $home = @$ '#Home i'
    $activities = @$ '#Activities i'
    $about = @$ '#About i'
    $photos = @$ '#Photos i'
    $home.addClass 'icon-home'
    $activities.addClass 'icon-globe'
    $about.addClass 'icon-coffee'
    $photos.addClass 'icon-camera-retro'

