@Demo.module "TalkApp.UserTalkList", (UserTalkList, App, Backbone, Marionette, $, _) ->


  class UserTalkList.Layout extends App.Views.Layout
    template: "talk/user_list/user_list_layout"

    regions:
      talksRegion:  "#talks-region"
      panelRegion:  "#talks-panel-region"
      newRegion:    "#new-talk-region"



  class UserTalkList.Panel extends App.Views.ItemView
    template: "talk/user_list/_panel"
    tagName: "ul"

    triggers:
      "click #new-talk" : "new:talk:button:clicked"



  class UserTalkList.Talk extends App.Views.ItemView
    template: "talk/user_list/_talk"
    className: 'talk_li edittalk'
    tagName: "li"


    triggers:
      "click .talk-edit"   : "talk:edit:clicked"
      "click"              : "talk:single:render"

  class UserTalkList.Empty extends App.Views.ItemView
    template: "talk/user_list/_empty"
    tagName: "li"


  class UserTalkList.Talks extends App.Views.CompositeView
    template: "talk/user_list/_talks"
    itemView: UserTalkList.Talk
    emptyView: UserTalkList.Empty
    itemViewContainer: "ul"
