@Demo.module "ConferenceApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
        { single, id, talks } = options
        single or= App.request "conference:entity", id

        App.execute "when:fetched", single, =>
          @layout = @getLayoutView single

          @listenTo @layout, "show", =>
            @titleRegion single
            @conferenceRegion single
            @talkContainerRegion

          @show @layout


    titleRegion: (single) ->
      titleView = @getTitleView single
      @layout.titleRegion.show titleView

    conferenceRegion: (single) ->
      conferenceView = @getConferenceView single
      @layout.conferenceRegion.show conferenceView


    getTitleView: (single) ->
      new Show.Title
        model: single

    getLayoutView: (single) ->
      new Show.Layout
        model: single

    getConferenceView: (single) ->
      new Show.Conference
        model: single
