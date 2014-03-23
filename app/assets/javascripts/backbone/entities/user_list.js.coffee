@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.UserList extends Entities.Model
    # initialize: (@conference_id) ->
    urlRoot: -> Routes.conferences_path()

  class Entities.UserListCollection extends Entities.Collection
  	model: Entities.UserList
  	url: -> '/user_list'

  API =
    getCurrentUserList: ->
      user_list = new Entities.UserListCollection
      user_list.fetch
        reset: true
      user_list
      # window.ss = user_list


  App.reqres.setHandler "user_list:entities", ->
    API.getCurrentUserList()
