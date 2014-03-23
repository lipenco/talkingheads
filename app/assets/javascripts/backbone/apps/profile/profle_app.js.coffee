@Demo.module "ProfileApp", (ProfileApp, App, Backbone, Marionette, $, _) ->

  class ProfileApp.Router extends Marionette.AppRouter
    appRoutes:
      "profile": "show"

  API =
    show: ->
      App.vent.trigger "header:choose", "Profile"
      meny.open()
      new ProfileApp.Show.Controller
  #
  #   newConference: (region) ->
  #     new App.ConferenceApp.New.Controller
  #       region: region
  #
  #
  # App.commands.setHandler "new:conference:single", (region) ->
  #   API.newConference region


  App.addInitializer ->
    new ProfileApp.Router
      controller: API
