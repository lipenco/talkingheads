@Demo.module "ConferenceApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Conference extends App.Views.ItemView
    template: "conference/list/conference"
