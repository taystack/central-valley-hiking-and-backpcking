'use strict'

# jquery ui exports manipulates and modifies $, which should be in the global
# scope right now.  Therefore we do not need to import jquery-core.  Same with
# bootstrap

require 'jquery-ui'
require 'bootstrap'

module.exports = $
