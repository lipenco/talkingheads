@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "talk/show/show_layout"

    regions:
      titleRegion:   "#title-region"
      videoRegion:   "#video-region"
      talksRegion:   "#talks-region"
      starRegion:    "#star-region"
      speakerRegion:  "#speaker-region"
      commentsRegion: "#comments-region"
      descriptionRegion : "#description-region"


  class Show.Title extends App.Views.ItemView
    template: "talk/show/_title"

  class Show.Speaker extends App.Views.ItemView
    template: "talk/show/_speaker"

  class Show.Description extends App.Views.ItemView
    template: "talk/show/_description"
    className: "description-cont"


  class Show.Video extends App.Views.ItemView
    template: "talk/show/_video"


  class Show.Talk extends App.Views.ItemView
    template: "talk/show/_talk"
    tagName: "li"

    triggers:
      "click"      : "talk:single:render"

    # onRender: ->
    #   App.vent.trigger 'app:show'



  class Show.Talks extends App.Views.CompositeView
    template: "talk/show/_talks"
    itemView: Show.Talk
    itemViewContainer: "ul"
