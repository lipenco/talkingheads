# @Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
#
#   class Entities.Favorites extends App.Entities.Collection
#
#     initialize: (@user_id, @talk_id) ->
#     url: -> "user/#{@user_id}/talks/#{@talk_id}/favorites"
#
#   API =
#     setNewFavorites: (user_id, talk_id) ->
#       new Entities.Favorites(user_id, talk_id)


  # App.reqres.setHandler "new:favorite:entity", (user_id, talk_id) ->
  #   API.setNewFavorites(user_id, talk_id)
