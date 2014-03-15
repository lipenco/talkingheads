@Demo.module "TalkApp", (TalkApp, App, Backbone, Marionette, $, _) ->

  class TalkApp.Router extends Marionette.AppRouter
    appRoutes:
      "conferences/:id/talk/:id" : "show"

  API =
    show: (id, talk) ->
      new TalkApp.Show.Controller
        id: id
        talks: talk
#
#
#   App.vent.on "talk:single:clicked", (talk) ->
#     App.navigate Routes.conference_talk_path(talk.conference_id, talk.id)
#     API.show talk.id, talk
#
#
#   # App.vent.on "talk:cancelled", (single) ->
#   #   App.navigate Routes.conferences_path(single.id)
#   #   API.show single.id, single
#
#
#
  App.addInitializer ->
    new TalkApp.Router
      controller: API
