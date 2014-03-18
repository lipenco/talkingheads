@Demo.module "AboutApp", (AboutApp, App, Backbone, Marionette, $, _) ->

  class AboutApp.Router extends Marionette.AppRouter
    appRoutes:
      "about": "show"

  API =
    show: ->
      App.vent.trigger "header:choose", "About"
      new AboutApp.Show.Controller


  App.addInitializer ->
    new AboutApp.Router
      controller: API
