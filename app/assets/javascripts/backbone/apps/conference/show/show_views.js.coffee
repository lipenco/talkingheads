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

  class Show.TalkSingle extends App.Views.ItemView
    template: "conference/show/_talk_single"
    className: 'talk_li'
    tagName: "li"

    triggers:
      "click .talk-delete" : "talk:delete:clicked"
      "click"              : "talk:single:clicked"
    initialize: ->
      window.ts = this


  class Show.Talks extends App.Views.CompositeView
    template: "conference/show/show_talks"
    itemView: Show.TalkSingle
    itemViewContainer: "ul"
