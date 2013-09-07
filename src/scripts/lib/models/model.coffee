'use strict'

Chaplin = require 'chaplin'
_ = require 'underscore'

#! Extends the chaplin model, well; we'll leave it a that.
module.exports = class Model extends Chaplin.Model

  # Mixin a synchronization state machine.
  _(@::).extend Chaplin.SyncMachine

  #! Name of the resource on the server (eg. 'accounts/user')
  name: undefined

  #! The current in-flight request.
  _request: null
