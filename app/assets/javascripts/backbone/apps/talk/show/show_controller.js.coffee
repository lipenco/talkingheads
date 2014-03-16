@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
        { id, talk_id, talk } = options
        talk or= App.request "talk:entity", id, talk_id
        window.id = id
        talks = App.request "talk:entities", id
        window.talks = talks

        App.execute "when:fetched", talk, =>

          @layout = @getLayoutView talk

          @listenTo @layout, "show", =>
            @titleRegion talk
            @videoRegion talk
            @nextRegion talk
            @talksRegion talks

          @show @layout

    talksRegion: (talks) ->
      talksView = @getTalksView talks

      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        App.vent.trigger "talk:single:render", args.model
        @titleRegion args.model
        @videoRegion args.model


      @layout.talksRegion.show talksView


    titleRegion: (talk) ->
      titleView = @getTitleView talk
      @layout.titleRegion.show titleView

    videoRegion: (talk) ->
      videoView = @getVideoView talk
      @layout.videoRegion.show videoView
      video = talk.get("video_url")

      pop = Popcorn.youtube( "#youtube", "#{video}" )


    nextRegion: (talk) ->
      nextView = @getNextView talk
      @layout.nextRegion.show nextView

    #
    # talksRegion: (single) ->
    #   talksView = @getTalksView single
    #
    #   @listenTo talksView, "childview:talk:single:clicked", (child, args) ->
    #     # window.s = args.model
    #     App.vent.trigger "talk:single:clicked", args.model
    #
    #   @listenTo talksView, "childview:talk:delete:clicked", (child, args) ->
    #     model = args.model
    #     if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy() else false
    #
    #
    #   @layout.talksRegion.show talksView
    #
    #
    # conferenceRegion: (single) ->
    #   conferenceView = @getConferenceView single
    #   @layout.conferenceRegion.show conferenceView

    getNextView: (talk) ->
      new Show.Next
        model: talk

    getTalksView: (talks) ->
      new Show.Talks
        collection: talks


    getVideoView: (talk) ->
      new Show.Video
        model: talk


    getTitleView: (talk) ->
      new Show.Title
        model: talk

    getLayoutView: (talk) ->
      new Show.Layout
        model: talk
