@Demo.module "ConferenceApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->
  
  class Edit.Layout extends App.Views.Layout
    template: "conference/edit/edit_layout"
    
    regions:
      titleRegion:  "#title-region"
      formRegion:   "#form-region"
  
  class Edit.Title extends App.Views.ItemView
    template: "conference/edit/edit_title"
    
    modelEvents:
      "updated" : "render"
  
  class Edit.Conference extends App.Views.ItemView
    template: "conference/edit/edit_conference"
  