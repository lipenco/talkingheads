@Demo.module "ConferenceApp", (ConferenceApp, App, Backbone, Marionette, $, _) ->


  class ConferenceApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences": "list"

  API = 
    list: ->
      new ConferenceApp.List.Controller


  App.addInitializer ->
    new ConferenceApp.Router
      controller: API
