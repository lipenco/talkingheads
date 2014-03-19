@Demo.module "ConferenceApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "conference/show/show_layout"

    regions:
      titleRegion:  "#title-region"
      conferenceRegion:   "#conference-region"
      talksRegion: "#talks-region"
      panelRegion:  "#talks-panel-region"

  class Show.Title extends App.Views.ItemView
    template: "conference/show/show_title"

  class Show.Panel extends App.Views.ItemView
    template: "conference/show/_panel"
    tagName: "ul"

    triggers:
      "click #new-talk" : "new:talk:button:clicked"


  class Show.Conference extends App.Views.ItemView
    template: "conference/show/show_conference"

  class Show.TalkSingle extends App.Views.ItemView
    template: "conference/show/_talk_single"
    className: 'talk_li'
    tagName: "li"

    triggers:
      "click .talk-delete" : "talk:delete:clicked"
      "click"              : "talk:single:clicked"



  class Show.Talks extends App.Views.CompositeView
    template: "conference/show/show_talks"
    itemView: Show.TalkSingle
    itemViewContainer: "ul"
