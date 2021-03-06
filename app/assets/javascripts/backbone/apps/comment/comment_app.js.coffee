@Demo.module "CommentApp", (CommentApp, App, Backbone, Marionette, $, _) ->


  API =
    list: (talk, region) ->
      new CommentApp.List.Controller
        talk: talk
        region: region


  App.commands.setHandler "get:talk:comments", (talk, region) ->
    API.list talk, region
