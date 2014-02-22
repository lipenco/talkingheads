@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
	
	class Entities.Header extends Entities.Model
	
	class Entities.HeaderCollection extends Entities.Collection
		model: Entities.Header
	
	API =
		getHeaders: ->
			new Entities.HeaderCollection [
				{ name: "Conferences" }
				{ name: "About" }
				{ name: "Sign up" }
			]
	
	App.reqres.setHandler "header:entities", ->
		API.getHeaders()