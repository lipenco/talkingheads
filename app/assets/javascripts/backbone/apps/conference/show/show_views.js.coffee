@Demo.module "ConferenceApp.Show", (Show, App, TalkApp, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "conference/show/show_layout"

    regions:
      titleRegion:  "#title-region"
      conferenceRegion:   "#conference-region"
      talkContainerRegion: "#talk-container"



  class Show.Title extends App.Views.ItemView
    template: "conference/show/show_title"


  class Show.Conference extends App.Views.ItemView
    template: "conference/show/show_conference"
