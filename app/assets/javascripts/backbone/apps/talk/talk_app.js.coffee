@Demo.module "TalkApp", (TalkApp, App, Backbone, Marionette, $, _) ->

  @startWithParent = false

  API =
    listTalks: ->
      new TalkApp.List.Controller

  TalkApp.on "start", ->
    API.listTalks()
