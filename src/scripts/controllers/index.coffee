'use strict'

Controller= require 'controllers/header'

View =
  Home: require 'views/home'
  Activities: require 'views/activities'
  About: require 'views/about'
  Photos: require 'views/photos'

module.exports = class Index extends Controller

  home: ->
    @view = new View.Home
      autoRender: true
      region: 'body'

  activities: ->
    @view = new View.Activities
      autoRender: true
      region: 'body'

  about: ->
    @view = new View.About
      autoRender: true
      region: 'body'

  photos: ->
    @view = new View.Photos
      autoRender: true
      region: 'body'
