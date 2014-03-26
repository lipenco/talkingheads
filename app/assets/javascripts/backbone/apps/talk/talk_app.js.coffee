@Demo.module "TalkApp", (TalkApp, App, Backbone, Marionette, $, _) ->

  class TalkApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences/:id/talks/:id"      : "showTalk"
      "conferences/:id/talks/:id/edit" : "editTalk"

  API =
    showTalk: (id, talk_id, talk) ->
      new TalkApp.Show.Controller
        id: id
        talk_id: talk_id
        talk: talk

    editTalk: (id, talk_id, talkk) ->
      new TalkApp.Edit.Controller
        id: id
        talk_id: talk_id
        talk: talkk
        region: App.formRegion



    newTalk: (talks, conference_id, region) ->
      new TalkApp.New.Controller
        conference_id: conference_id
        collection: talks
        region: region

    userListTalk: (conference_id, talks) ->
      new TalkApp.UserTalkList.Controller
        region: App.talksListRegion
        conference_id: conference_id
        talks: talks





  App.vent.on "talk:single:clicked", (id, talk_id, talk) ->
    talk_id = talk.get("id")
    id = talk.get("conference_id")
    App.navigate Routes.conference_talk_path(id, talk_id)
    API.showTalk  id, talk_id, talk

  App.vent.on "talk:single:render", (talk) ->
    talk_id = talk.get("id")
    id = talk.get("conference_id")
    App.navigate Routes.conference_talk_path(id, talk_id)
    API.showTalk  id, talk_id

  App.commands.setHandler "new:talk:single", (talks, conference_id, region) ->
    API.newTalk talks, conference_id, region

  App.vent.on "talk:edit:clickedd", (id, talk_id, talkk) ->
    App.navigate Routes.edit_conference_talk_path(id, talk_id)
    API.editTalk id, talk_id, talkk

  App.commands.setHandler "talk:edit:list", (conference_id, talks) ->
    API.userListTalk conference_id, talks

  App.vent.on "talk:updated", (talk) ->
    window.ttt = talk
    talk_id = talk.talk_id
    id = talk.id
    App.navigate Routes.conference_talk_path(id, talk_id)
    API.showTalk  id, talk_id




  App.addInitializer ->
    new TalkApp.Router
      controller: API
