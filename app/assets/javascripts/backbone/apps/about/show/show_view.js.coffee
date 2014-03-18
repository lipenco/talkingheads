@Demo.module "AboutApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "about/show/show_layout"

    regions:
      fooRegion: "#foo-region"
