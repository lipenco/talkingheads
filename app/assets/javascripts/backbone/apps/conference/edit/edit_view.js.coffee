@Demo.module "ConferenceApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "conference/edit/edit_layout"

    regions:
      titleRegion:  "#title-region"
      formRegion:   "#form-region"

  class Edit.Title extends App.Views.ItemView
    template: "conference/edit/edit_title"
    className: "container"

    triggers:
      "click #publish" : "conference:publish:clicked"

    modelEvents:
      "updated" : "render"

  class Edit.Conference extends App.Views.ItemView
    template: "conference/edit/edit_conference"

    triggers:
      "click .conference-delete" : "conference:delete:clicked"

    onRender: ->
       @addDayPicker()

    addDayPicker: ->
      @$el.find('#dp1').datepicker()
