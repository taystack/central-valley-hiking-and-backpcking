'use strict'

View = require 'lib/views/view'
Template = require 'templates/home'

module.exports = class Home extends View

  template: Template

  id: 'home'

  events:
    'click .submit': (event) ->
      event.preventDefault()
      console.log 'submit'

    'focus #comments': ->
      @$('#comments').animate
        height: '+=50'
      ,
        100

    'blur #comments': ->
      @$('#comments').animate
        height: '-=50'
      ,
        100

    'click .thing': ->
      $thingie = @$('.thingie')
      $scroll = $thingie[0].offsetTop
      console.log $scroll
      $(window).scrollTop($scroll)

    "keyup input[id^='number-']": (event) ->
      console.log @$('#number-field').val().length
      if @$('#number-field').val().length is 3
        @$('#number-two').focus()
      if @$('#number-two').val().length is 3
        @$('#number-three').focus()
      # if @$('#number-three').val().length is 4
      #   @$('#comments').focus()
