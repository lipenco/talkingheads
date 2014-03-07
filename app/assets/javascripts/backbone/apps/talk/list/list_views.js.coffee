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

    // triggers:
    //   "click #new-conference" : "new:conference:button:clicked"

  class List.Talk extends App.Views.ItemView
    template: "talk/list/_talk"
    className: 'talk_li'
    tagName: "li"

      
    // triggers:
    //   "click .conference-delete" : "conference:delete:clicked"
    //   "click .conference-edit"   : "conference:single:edit"
    //   "click"                    : "conference:single:details"

  class List.Conference extends App.Views.CompositeView
    template: "conference/list/_conference"
    itemView: List.ConferenceSingle
    itemViewContainer: "ul"
    onRender: ->
       @childElementsFadeIn()
    
    childElementsFadeIn: ->
      duration = 200;
      @$el.find('.conference_li').each (index) ->
        $(this).hide()
        $(this).delay((index+1) * duration).fadeIn(400)


