@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Entities.User extends Entities.Model

	# class Entities.UsersCollection extends Entities.Collection
	# 	model: Entities.User
	# 	url: -> Routes.users_path()

	API =
		setCurrentUser: (currentUser) ->
			new Entities.User currentUser


	App.reqres.setHandler "set:current:user", (currentUser) ->
		window.ent = currentUser
		API.setCurrentUser currentUser
