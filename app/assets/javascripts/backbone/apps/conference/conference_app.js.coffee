@Demo.module "ConferenceApp", (ConferenceApp, App, Backbone, Marionette, $, _) ->


  class ConferenceApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences": "list"

  API = 
    list: ->
      new ConferenceApp.List.Controller

    newConference: (region) ->
      new ConferenceApp.New.Controller
        region: region

  App.commands.setHandler "new:conference:single", (region) ->
    API.newConference region


  App.addInitializer ->
    new ConferenceApp.Router
      controller: API
