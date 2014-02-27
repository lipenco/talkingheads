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

  class List.Panel extends App.Views.ItemView
    template: "conference/list/_panel"

  class List.ConferenceSingle extends App.Views.ItemView
    template: "conference/list/_conference_single"
    tagName: "li"
    className: "conference-single"
      
    # triggers:
    #   "click .crew-delete button" : "crew:delete:clicked"
    #   "click"                     : "crew:member:clicked"

  class List.Conference extends App.Views.CompositeView
    template: "conference/list/_conference"
    itemView: List.ConferenceSingle
    emptyView: List.Empty
    itemViewContainer: "ul"


