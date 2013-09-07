'use strict'

module.exports = (match) ->

  match '', 'index#home'
  match 'home', 'index#home'
  match 'activities', 'index#activities'
  match 'about', 'index#about'
  match 'photos', 'index#photos'
