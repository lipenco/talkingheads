@Demo.module "ConferenceApp", (ConferenceApp, App, Backbone, Marionette, $, _) ->


  class ConferenceApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences": "list"
      "conferences/:id/edit" : "edit"
      "conferences/:id" : "show"

  API = 
    list: ->
      new ConferenceApp.List.Controller

    newConference: (region) ->
      new ConferenceApp.New.Controller
        region: region

    edit: (id, single) ->
      new ConferenceApp.Edit.Controller
        id: id
        conferences: single

    show: (id, single) ->
      new ConferenceApp.Show.Controller
        id: id
        conferences: single

  App.commands.setHandler "new:conference:single", (region) ->
    API.newConference region

  App.vent.on "conference:single:edit conference:created", (single) ->
    App.navigate Routes.edit_conference_path(single.id)
    API.edit single.id, single

  App.vent.on "conference:single:details", (single) ->
    App.navigate Routes.conference_path(single.id)
    API.show single.id, single
  
  
  App.vent.on "conference:cancelled conference:updated", (conferences) ->
    App.navigate Routes.conferences_path()
    API.list()


  App.addInitializer ->
    new ConferenceApp.Router
      controller: API
