@Demo.module "ConferenceApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Layout extends App.Views.Layout
    template: "conference/list/list_layout"

    regions:
      titleRegion:  "#title-region"

    

  class List.Title extends App.Views.ItemView
    template: "conference/list/_title"


