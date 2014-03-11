@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "talk/list/list_layout"

    regions:
      titleRegion:  "#title-region"
      panelRegion:  "#panel-region"
      newRegion:    "#new-region"
      talkRegion:   "#talk-region"


  class List.Title extends App.Views.ItemView
    template: "talk/list/_title"
    className: "col-centred"

  class List.Panel extends App.Views.ItemView
    template: "talk/list/_panel"
    tagName: "ul"

    triggers:
      "click #new-talk" : "new:talk:button:clicked"

  class List.Talk extends App.Views.ItemView
    template: "talk/list/_talk_single"
    className: 'talk_li'
    tagName: "li"



    # triggers:
    #   "click .talk-delete" : "talk:delete:clicked"
    #   "click .talk-edit"   : "talk:single:edit"
    #   "click"              : "talk:single:play"

  class List.Talk extends App.Views.CompositeView
    template: "talk/list/_talk"
    itemView: List.Talk
    itemViewContainer: "ul"
