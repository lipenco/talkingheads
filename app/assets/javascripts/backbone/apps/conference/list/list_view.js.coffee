@Demo.module "ConferenceApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "conference/list/list_layout"

    regions:
      titleRegion:      "#title-region"
      panelRegion:      "#panel-region"
      newRegion:        "#new-region"
      conferenceRegion: "#conference-region"




  class List.Title extends App.Views.ItemView
    template: "conference/list/_title"
    className: "col-centred"

  class List.Panel extends App.Views.ItemView
    template: "conference/list/_panel"
    className: "row"

    events:
      "click ul li" : "isotopeFilter"
      "keydown #search-input" : "search"

    search: (e) =>
      if (e.keyCode ==13)
        q = @.$el.find("#search-input").val()
        @trigger "query:get", (q)



    isotopeFilter: (e) =>
      container = $("#conference-region")
      if e.target.parentElement.attributes[0]
        color = e.target.parentElement.attributes[0].value
        unless color is "orange"
          container.isotope
            itemSelector: ".note"
            filter: ".#{color}"
        else
          container.isotope
            itemSelector: ".note"
            filter: "*"


  class List.ConferenceSingle extends App.Views.ItemView
    template: "conference/list/_conference_single"
    className: 'conference_li'
    tagName: "li"

    triggers:
      "click"                    : "conference:single:details"

  class List.Conference extends App.Views.CompositeView
    template: "conference/list/_conference"
    itemView: List.ConferenceSingle
    itemViewContainer: "ul"
    onShow: ->
       @childElementsFadeIn()

    childElementsFadeIn: ->
      container = @$el
      container.isotope
        layoutMode : 'masonry'
        animationOptions:
          duration: 500
          easing: "swing"

        itemSelector: ".note"

      #
      # duration = 200;
      # @$el.find('.conference_li').each (index) ->
      #   $(this).hide()
      #   $(this).delay((index+1) * duration).fadeIn(400)
