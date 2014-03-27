@Demo.module "ConferenceApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      { single, id } = options
      single or= App.request "conference:entity", id
      meny.close()
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()

      @layout = @getLayoutView single

      @listenTo @layout, "show", =>
        @titleRegion single
        @conferenceRegion single
        @talksRegion single, id

      @show @layout, loading: true


    titleRegion: (single) ->
      titleView = @getTitleView single
      @show titleView, region: @layout.titleRegion
      # @layout.titleRegion.show titleView


    talksRegion: (single, id) ->
      App.execute "list:talks:view", single, id, @layout.talksRegion



    conferenceRegion: (single) ->
      conferenceView = @getConferenceView single
      @layout.conferenceRegion.show conferenceView
      # @show conferenceView region: @layout.conferenceRegion



    getTitleView: (single) ->
      new Show.Title
        model: single

    getLayoutView: (single) ->
      new Show.Layout
        model: single

    getConferenceView: (single) ->
      new Show.Conference
        model: single
