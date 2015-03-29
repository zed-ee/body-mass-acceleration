require('lib/setup')

Spine = require('spine')
Main = require('controllers/main')
class App extends Spine.Controller
	constructor: (params)->
		super
		@main = new Main('el': '#main', data: params.data)
		#@append @main
		@log "App.constructor"
		
module.exports = App
    