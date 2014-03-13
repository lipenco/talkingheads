@Demo.module "ConferenceApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
        { single, id } = options
        single or= App.request "conference:entity", id

        App.execute "when:fetched", single, =>
          @layout = @getLayoutView single

          @listenTo @layout, "show", =>
            @titleRegion single
            @conferenceRegion single
            @talksRegion single

          @show @layout


    titleRegion: (single) ->
      titleView = @getTitleView single
      @layout.titleRegion.show titleView

    talksRegion: (single) ->
      talksView = @getTalksView single
      @layout.talksREgion.show talksView

    conferenceRegion: (single) ->
      conferenceView = @getConferenceView single
      @layout.conferenceRegion.show conferenceView


    getTalksView: (single) ->
      new Show.Talks
        # model: single
        collection: new Backbone.Collection single.get("talks")
        # console.log new Backbone.Collection single.get("talks")
        #change model for associated

    getTitleView: (single) ->
      new Show.Title
        model: single

    getLayoutView: (single) ->
      new Show.Layout
        model: single

    getConferenceView: (single) ->
      new Show.Conference
        model: single
