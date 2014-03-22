@Demo.module "ProfileApp", (ProfileApp, App, Backbone, Marionette, $, _) ->

  class ProfileApp.Router extends Marionette.AppRouter
    appRoutes:
      "profile": "show"

  API =
    show: ->
      App.vent.trigger "header:choose", "Profile"
      meny.open()
      new ProfileApp.Show.Controller


  App.addInitializer ->
    new ProfileApp.Router
      controller: API
