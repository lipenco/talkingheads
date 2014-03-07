@Demo.module "TalkApp", (TalkApp, App, Backbone, Marionette, $, _) ->


  class TalkApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences/:id/talks": "list"
      "conferences/:id/talk/:id/edit" : "edit"
      "conferences/:id/talk/:id" : "show"

  API = 
    list: ->
      new TalkApp.List.Controller  

    newTalk: (region) ->
      new TalkApp.New.Controller
        region: region

    edit: (id, single) ->
      new TalkApp.Edit.Controller
        id: id
        talks: single

    show: (id, single) ->
      new TalksApp.Show.Controller
        id: id
        talks: single

  App.commands.setHandler "new:talk:single", (region) ->
    API.newTalk region

  App.vent.on "talk:single:edit talk:created", (single) ->
    App.navigate Routes.edit_conference_talk_path(single.id)
    API.edit single.id, single

  App.vent.on "talk:single:play", (single) ->
    App.navigate Routes.conference_talk_path(single.id)
    API.show single.id, single
  
  
  App.vent.on "talk:cancelled talk:updated", (talks) ->
    App.navigate Routes.conference_talks_path()
    API.list()


  App.addInitializer ->
    new TalkApp.Router
      controller: API

