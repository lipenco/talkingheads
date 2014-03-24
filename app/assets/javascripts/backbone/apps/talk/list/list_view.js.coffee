@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->


  class List.Layout extends App.Views.Layout
    template: "talk/list/list_layout"

    regions:
      talksRegion:  "#talks-region"





  class List.Talk extends App.Views.ItemView
    template: "talk/list/_talk"
    className: 'talk_li'
    tagName: "li"

    triggers:
      "click .talk-delete" : "talk:delete:clicked"
      "click"              : "talk:single:clicked"

  class List.Empty extends App.Views.ItemView
    template: "talk/list/_empty"
    tagName: "li"


  class List.Talks extends App.Views.CompositeView
    template: "talk/list/_talks"
    itemView: List.Talk
    emptyView: List.Empty
    itemViewContainer: "ul"
