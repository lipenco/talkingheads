@Demo.module "ProfileApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "profile/show/show_layout"

    regions:
      nameRegion: "#name-region"
      loginRegion: "#login-region"
      logoutRegion: "#logout-region"


  class Show.Name extends App.Views.ItemView
    template: "profile/show/_name"


  class Show.Login extends App.Views.ItemView
    template: "profile/show/_login"
