@Demo.module "ConferenceApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      { single, id } = options
      single or= App.request "conference:entity", id
      meny.close()
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()
      # App.execute "when:fetched", single, =>
      @layout = @getLayoutView single

      @listenTo @layout, "show", =>
        @titleRegion single
        @conferenceRegion single
        @talksRegion single

      @show @layout, loading: true


    titleRegion: (single) ->
      titleView = @getTitleView single
      @show titleView, region: @layout.titleRegion
      # @layout.titleRegion.show titleView


    talksRegion: (single) ->
      talksView = @getTalksView single

      @listenTo talksView, "childview:talk:single:clicked", (child, args) ->
        window.args = child
        model = args.model
        id = model.get("conference_id")
        talk_id = model.get("id")
        App.vent.trigger "talk:single:clicked", id, talk_id, args.model

      @listenTo talksView, "childview:talk:delete:clicked", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy(model.id) else false


      @layout.talksRegion.show talksView
      # @show talksView region: @layout.talksRegion


    conferenceRegion: (single) ->
      conferenceView = @getConferenceView single
      @layout.conferenceRegion.show conferenceView
      # @show conferenceView region: @layout.conferenceRegion


    getTalksView: (single) ->
      window.single = single
      talks = single.get("talks")
      new Show.Talks
        collection: talks



    getTitleView: (single) ->
      new Show.Title
        model: single

    getLayoutView: (single) ->
      new Show.Layout
        model: single

    getConferenceView: (single) ->
      new Show.Conference
        model: single
