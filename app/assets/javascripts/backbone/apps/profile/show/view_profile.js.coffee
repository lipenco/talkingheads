@Demo.module "ProfileApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "profile/show/show_layout"

    regions:
      nameRegion: "#name-region"
      loginRegion: "#login-region"
      logoutRegion: "#logout-region"
      panelRegion: "#panel-region"
      newRegion: "#new-region"
      conferencesRegion: "#conferences-region"


  class Show.Name extends App.Views.ItemView
    template: "profile/show/_name"


  class Show.Login extends App.Views.ItemView
    template: "profile/show/_login"

  class Show.Panel extends App.Views.ItemView
    template: "profile/show/_panel"

    triggers:
      "click #new-conference" : "new:conference:button:clicked"

  class Show.Conference extends App.Views.ItemView
    template: "profile/show/_conf_single"
    className: 'conference_li'
    tagName: "li"

    triggers:
      "click .conference-delete" : "conference:delete:clicked"
      "click .conference-edit"   : "conference:single:edit"
      "click"                    : "conference:single:details"


  class Show.User_List extends App.Views.CompositeView
    template: "profile/show/_conf_list"
    itemView: Show.Conference
    itemViewContainer: "ul"
