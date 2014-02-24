@Demo.module "ConferenceApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    list: ->
      @layout = @getLayoutView()

      @layout.on "show", =>
        @titleRegion()

      App.mainRegion.show @layout

    titleRegion: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    getTitleView: ->
      new List.Title

    getLayoutView: ->
      new List.Layout


