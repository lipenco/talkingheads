@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.UserListCollection extends Entities.Collection
    model: Entities.Conference
    url: -> '/user_list'



  API =
    getCurrentUserList: ->
      user_list = new Entities.UserListCollection
      user_list.fetch
        reset: true
      user_list

  App.reqres.setHandler "user_list:entities", ->
    API.getCurrentUserList()
