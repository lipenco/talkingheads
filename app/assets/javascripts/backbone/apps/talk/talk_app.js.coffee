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

    listTalks: (single, id, region) ->
      new TalkApp.List.Controller
        single: single
        id: id
        region: region

    newTalk: (talks, region) ->
      new TalkApp.New.Controller
        talks: talks
        region: region

    listSearchedTalks: (q, region) ->
      new TalkApp.Search.Controller
        q: q
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

  App.vent.on "talk:single:rendered", (conference_id, id) ->
    App.navigate Routes.conference_talk_path(conference_id, id)

  App.vent.on "talk:single:render", (talk) ->
    talk_id = talk.get("id")
    id = talk.get("conference_id")
    App.navigate Routes.conference_talk_path(id, talk_id)
    API.showTalk  id, talk_id

  App.commands.setHandler "new:talk:single", (talks, region) ->
    API.newTalk talks, region

  App.vent.on "list:searched:talks", (q, region) ->
    API.listSearchedTalks q, region


  App.commands.setHandler "list:talks:view", (single, id, region) ->
    API.listTalks single, id, region

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
