@Demo.module "AboutApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: ->
      meny.close()
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()

      @layout = @getLayoutView()

      @listenTo @layout, "show", =>

      @show @layout

    getLayoutView: ->
      new Show.Layout
