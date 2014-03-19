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

    newTalk: (conference_id) ->
      new TalkApp.New.Controller
        conference_id: conference_id




  App.vent.on "talk:single:clicked", (id, talk_id, talk) ->
    talk_id = talk.get("id")
    id = talk.get("conference_id")
    App.navigate Routes.conference_talk_path(id, talk_id)
    API.showTalk  id, talk_id, talk

  App.vent.on "talk:single:render", (talk) ->
    talk_id = talk.get("id")
    id = talk.get("conference_id")
    App.navigate Routes.conference_talk_path(id, talk_id)

  App.commands.setHandler "new:talk:single", (conference_id) ->
    console.log conference_id
    API.newTalk conference_id





  App.addInitializer ->
    new TalkApp.Router
      controller: API
