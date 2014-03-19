@Demo.module "TalkApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Talk extends App.Views.ItemView
    template: "talk/new/new_talk"

    form:
      buttons:
        placement: "left"
