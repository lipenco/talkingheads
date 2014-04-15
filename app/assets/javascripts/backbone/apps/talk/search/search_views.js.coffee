@Demo.module "TalkApp.Search", (Search, App, Backbone, Marionette, $, _) ->

  class Search.Layout extends App.Views.Layout
    template: "talk/search/search_layout"

    regions:
      talksRegion:     "#tallks-region"



  class Search.TalkSingle extends App.Views.ItemView
    template: "talk/list/_talk"
    className: 'talk_li'
    tagName: "li"

    triggers:
      "click"              : "talk:single:clicked"



  class Search.Talks extends App.Views.CompositeView
    template: "talk/search/_talks"
    itemView: Search.TalkSingle
    itemViewContainer: "ul"
    onShow: ->
       @childElementsFadeIn()

    childElementsFadeIn: ->
      container = @$el.find("ul")
      container.isotope
        itemSelector: ".talk-container"

    events:
      "keydown #search-input" : "search"

    search: (e) =>
      if (e.keyCode ==13)
        q = @.$el.find("#search-input").val()
        @trigger "query:get", (q)
