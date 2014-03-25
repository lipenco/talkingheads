@Demo.module "ConferenceApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Conference extends App.Views.ItemView
    template: "conference/new/new_conference"

    modelEvents:
      "created" : "render"

    form:
      buttons:
        placement: "left"
