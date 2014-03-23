@Demo.module "ConferenceApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "conference/edit/edit_layout"

    regions:
      titleRegion:  "#title-region"
      formRegion:   "#form-region"
      panelRegion:  "#talks-panel-region"
      newRegion:    "#new-talk-region"


  class Edit.Panel extends App.Views.ItemView
    template: "conference/edit/_panel"
    tagName: "ul"

    triggers:
      "click #new-talk" : "new:talk:button:clicked"


  class Edit.Title extends App.Views.ItemView
    template: "conference/edit/edit_title"

    modelEvents:
      "updated" : "render"

  class Edit.Conference extends App.Views.ItemView
    template: "conference/edit/edit_conference"
