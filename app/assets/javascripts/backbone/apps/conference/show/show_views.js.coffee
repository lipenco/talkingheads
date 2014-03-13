@Demo.module "ConferenceApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "conference/show/show_layout"

    regions:
      titleRegion:  "#title-region"
      conferenceRegion:   "#conference-region"
      talksREgion: "#talks-region"

  class Show.Title extends App.Views.ItemView
    template: "conference/show/show_title"


  class Show.Conference extends App.Views.ItemView
    template: "conference/show/show_conference"

  class Show.Talks extends App.Views.CompositeView
    template: "conference/show/show_talks"
    # initialize: ->
    #   @collection = @model.get("childcollection")
    #   console.log @model.get("childcollection")
