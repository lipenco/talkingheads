@Demo.module "TalkApp.Search", (Search, App, Backbone, Marionette, $, _) ->

  class Search.Layout extends App.Views.Layout
    template: "talk/list/list_layout"

    regions:
      talksRegion:     "#talks-region"



  class Search.TalkSingle extends App.Views.ItemView
    template: "talk/list/_talk"
    className: 'talk_li'
    tagName: "li"

    triggers:
      "click"              : "talk:single:clicked"



  class Search.Talks extends App.Views.CompositeView
    template: "talk/list/_talks"
    itemView: Search.TalkSingle
    itemViewContainer: "ul"
    onShow: ->
       @childElementsFadeIn()

    childElementsFadeIn: ->
      container = @$el.find("ul")
      container.isotope
        itemSelector: ".talk-container"
