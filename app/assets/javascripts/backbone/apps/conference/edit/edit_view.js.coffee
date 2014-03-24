@Demo.module "ConferenceApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "conference/edit/edit_layout"

    regions:
      titleRegion:  "#title-region"
      formRegion:   "#form-region"
      talksListRegion:   "#talk-list-region"
      panelRegion:  "#talks-panel-region"
      newRegion:    "#new-talk-region"


  class Edit.Panel extends App.Views.ItemView
    template: "conference/edit/_panel"
    tagName: "ul"

    triggers:
      "click #new-talk" : "new:talk:button:clicked"


  class Edit.Title extends App.Views.ItemView
    template: "conference/edit/edit_title"

    modelEvents:
      "updated" : "render"

  class Edit.Conference extends App.Views.ItemView
    template: "conference/edit/edit_conference"

    triggers:
      "click .conference-delete" : "conference:delete:clicked"


  class Edit.Talk extends App.Views.ItemView
    template: "conference/edit/_talk"
    className: 'talk_li'
    tagName: "li"

    triggers:
      "click .talk-delete" : "talk:delete:clicked"
      "click"              : "talk:single:clicked"

  class Edit.Empty extends App.Views.ItemView
	   template: "conference/edit/_empty"
	   tagName: "li"

  class Edit.Talks extends App.Views.CompositeView
    template: "conference/edit/_talks"
    itemView: Edit.Talk
    emptyView: Edit.Empty
    itemViewContainer: "ul"
