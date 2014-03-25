@Demo = do (Backbone, Marionette) ->

	App = new Marionette.Application

	App.addRegions
		menyRegion: "#meny"
		headerRegion: "#header-region"
		mainRegion:		"#main-region"
		footerRegion: "#footer-region"
		talksListRegion: "#talk-list-region"
		formRegion: "#form-region"
		titleRegion: "#title-region"


	App.rootRoute = Routes.conferences_path()

	App.on "initialize:before", (options) ->
		@currentUser = App.request "set:current:user", options.currentUser

	App.reqres.setHandler "get:current:user", ->
		App.currentUser

	App.addInitializer ->
		App.module("HeaderApp").start()
		App.module("FooterApp").start()


	App.reqres.setHandler "default:region", ->
		App.mainRegion


	App.on "initialize:after", ->
		@startHistory()
		@navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

	App
