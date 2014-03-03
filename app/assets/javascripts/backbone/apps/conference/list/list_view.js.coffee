@Demo.module "ConferenceApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Layout extends App.Views.Layout
    template: "conference/list/list_layout"

    regions:
      titleRegion:  "#title-region"
      panelRegion:  "#panel-region"
      newRegion:    "#new-region"
      conferenceRegion:   "#conference-region"


  class List.Title extends App.Views.ItemView
    template: "conference/list/_title"
    className: "col-centred"

  class List.Panel extends App.Views.ItemView
    template: "conference/list/_panel"

    triggers:
      "click #new-conference" : "new:conference:button:clicked"

  class List.ConferenceSingle extends App.Views.ItemView
    template: "conference/list/_conference_single"
    className: 'conference_li'
    tagName: "li"

      
    triggers:
      "click .conference-delete" : "conference:delete:clicked"
      "click .conference-edit"   : "conference:single:edit"
      "click"                    : "conference:single:details"

  class List.Conference extends App.Views.CompositeView
    template: "conference/list/_conference"
    itemView: List.ConferenceSingle
    itemViewContainer: "ul"
    onRender: ->
       @childElementsFadeIn()
    
    childElementsFadeIn: ->
      duration = 500;
      @$el.find('.conference_li').each (index) ->
        $(this).hide()
        $(this).delay((index+1) * duration).fadeIn(500)


