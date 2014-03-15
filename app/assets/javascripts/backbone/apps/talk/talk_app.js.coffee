@Demo.module "TalkApp", (TalkApp, App, Backbone, Marionette, $, _) ->

  class TalkApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences/:id/talks/:id" : "showTalk"

  API =
    showTalk: (id, talk_id, talk) ->
      new TalkApp.Show.Controller
        id: id
        talk_id: talk_id
        talk: talk


  App.vent.on "talk:single:clicked", (talk) ->
    id = talk.get("id")
    conference_id = talk.get("conference_id")
    App.navigate Routes.conference_talk_path(conference_id, id)
    API.showTalk  id, talk




  App.addInitializer ->
    new TalkApp.Router
      controller: API
