@Demo.module "FavoritesApp", (FavoritesApp, App, Backbone, Marionette, $, _) ->

  class FavoritesApp.Router extends Marionette.AppRouter
    appRoutes:
      "favorites": "list"

  API =
    list: ->
      App.vent.trigger "header:choose", "Favorites"
      new FavoritesApp.List.Controller


  App.addInitializer ->
    new FavoritesApp.Router
      controller: API
