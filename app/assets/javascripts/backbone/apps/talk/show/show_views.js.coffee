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
    # initialize: (@id) ->

    template: "talk/show/_talk"
    tagName: "li"

    triggers:
      "click"      : "talk:single:render"



  class Show.Talks extends App.Views.CompositeView
    template: "talk/show/_talks"
    itemView: Show.Talk
    itemViewContainer: "ul"
