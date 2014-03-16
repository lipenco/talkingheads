@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "talk/show/show_layout"

    regions:
      titleRegion:  "#title-region"
      videoRegion:  "#video-region"
      talksRegion:  "#talks-region"
      nextRegion:  "#next-region"

  class Show.Title extends App.Views.ItemView
    template: "talk/show/_title"


  class Show.Video extends App.Views.ItemView
    template: "talk/show/_video"

  class Show.Next extends App.Views.ItemView
    template: "talk/show/_next"

  class Show.Talk extends App.Views.ItemView
    template: "talk/show/_talk"
    className: 'talk_li'
    tagName: "li"


  class Show.Talks extends App.Views.CompositeView
    template: "talk/show/_talks"
    itemView: Show.Talk
    itemViewContainer: "ul"



  # class Show.TalkSingle extends App.Views.ItemView
  #   template: "conference/show/_talk_single"
  #   className: 'talk_li'
  #   tagName: "li"
  #
  #   triggers:
  #     "click .talk-delete" : "talk:delete:clicked"
  #     "click"              : "talk:single:clicked"
  #   initialize: ->
  #     window.ts = this
  #
  #
  # class Show.Talks extends App.Views.CompositeView
  #   template: "conference/show/show_talks"
  #   itemView: Show.TalkSingle
  #   itemViewContainer: "ul"
