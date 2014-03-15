@Demo.module "TalkApp", (TalkApp, App, Backbone, Marionette, $, _) ->

  class TalkApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences/:id/talk/:id" : "showTalk"

  API =
    show: (id, talk) ->
      new TalkApp.Show.Controller
        id: id
        talks: talk

    showTalk: (id, talk) ->
      new TalkApp.Show.Controller
        id: id
        talk: talk


  App.vent.on "talk:single:clicked", (talk) ->
    id = talk.get("id")
    conference_id = talk.get("conference_id")
    App.navigate Routes.conference_talk_path(conference_id, id)
    API.showTalk  id, talk


  # App.vent.on "talk:cancelled", (single) ->
  #   App.navigate Routes.conferences_path(single.id)
  #   API.show single.id, single



  App.addInitializer ->
    new TalkApp.Router
      controller: API
