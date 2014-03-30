# @Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
#
#   class Entities.Favorites extends App.Entities.Collection
#     url: -> 'user/:id/favorites'
#
#
#   API =
#     setCurrentFavorites: (currentUser) ->
#       new Entities.Favorites currentUser
#
#
#   App.reqres.setHandler "set:current:favorites", (currentUser) ->
#     API.setCurrentFavorites currentUser
