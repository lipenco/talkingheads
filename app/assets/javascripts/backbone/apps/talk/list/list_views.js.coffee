@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "talk/list/list_layout"

    regions:
      talksRegion:     "#talks-region"



  class List.TalkSingle extends App.Views.ItemView
    template: "talk/list/_talk"
    className: 'talk_li'
    tagName: "li"

    triggers:
      "click"              : "talk:single:clicked"



  class List.Talks extends App.Views.CompositeView
    template: "talk/list/_talks"
    itemView: List.TalkSingle
    itemViewContainer: "ul"
    onShow: ->
       @childElementsFadeIn()

    childElementsFadeIn: ->
      container = @$el.find("ul")
      container.isotope
        itemSelector: ".talk-container"
