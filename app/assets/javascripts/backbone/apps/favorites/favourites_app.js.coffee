@Demo.module "FavoritesApp", (FavoritesApp, App, Backbone, Marionette, $, _) ->

  class FavoritesApp.Router extends Marionette.AppRouter
    appRoutes:
      "favorites": "list"

  API =
    list: ->
      App.vent.trigger "header:choose", "Favorites"
      new FavoritesApp.List.Controller

    getStar: (talk, region) ->
      new FavoritesApp.GetStar.Controller
        talk: talk
        region: region


  App.commands.setHandler "star:for:talk", (talk, region) ->
    API.getStar talk, region


  App.addInitializer ->
    new FavoritesApp.Router
      controller: API
