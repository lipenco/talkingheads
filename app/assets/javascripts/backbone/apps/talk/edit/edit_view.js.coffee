@Demo.module "TalkApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "talk/edit/edit_layout"

    regions:
      titleRegion:  "#title-region"
      formRegion:   "#form-region"



  class Edit.Title extends App.Views.ItemView
    template: "talk/edit/_title"

    modelEvents:
      "updated" : "render"

  class Edit.Talk extends App.Views.ItemView
    template: "talk/edit/_talk"

    triggers:
      "click .talk-delete" : "talk:delete:clicked"
