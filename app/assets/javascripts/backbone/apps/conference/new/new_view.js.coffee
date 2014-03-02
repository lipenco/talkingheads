@Demo.module "ConferenceApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Conference extends App.Views.ItemView
    template: "conference/new/new_conference"

    form:
      buttons:
        placement: "left"