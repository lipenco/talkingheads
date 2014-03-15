@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "talk/show/show_layout"

    regions:
      titleRegion:  "#title-region"
      videoRegion:  "#video-region"
      nextRegion:  "#next-region"

  class Show.Title extends App.Views.ItemView
    template: "talk/show/_title"


  class Show.Video extends App.Views.ItemView
    template: "talk/show/_video"

  class Show.Next extends App.Views.ItemView
    template: "talk/show/_next"

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
