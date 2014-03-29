@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      { id, talk_id, talk } = options
      talk or= App.request "talk:entity", id, talk_id
      talks = App.request "talk:entities", id
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()

      @layout = @getLayoutView talk

      @listenTo @layout, "show", =>
        @titleRegion talk
        @videoRegion talk
        @nextRegion talk
        @talksRegion talks, talk
        @starRegion talk

      @show @layout, loading: true



    talksRegion: (talks, talk) ->
      talksView = @getTalksView talks, talk


      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        @titleRegion args.model
        @videoRegion args.model
        @starRegion args.model
        childview = child.$el
        @manageHighlight(childview)


      # @layout.talksRegion.show talksView
      @show talksView, region: @layout.talksRegion, loading: true


    titleRegion: (talk) ->
      titleView = @getTitleView talk
      @layout.titleRegion.show titleView

    starRegion: (talk) ->
      App.execute "star:for:talk", talk,  @layout.starRegion


    videoRegion: (talk) ->
      videoView = @getVideoView talk
      @layout.videoRegion.show videoView
      video = talk.get("video_url")

      pop = Popcorn.youtube( "#youtube", "#{video}" )


    manageHighlight: (childView) ->
      $("li").removeClass('highlight')
      childView.addClass('highlight')


    nextRegion: (talk) ->
      nextView = @getNextView talk
      @layout.nextRegion.show nextView



    getNextView: (talk) ->
      new Show.Next
        model: talk

    getTalksView: (talks, talk) ->
      new Show.Talks
        collection: talks
        model: talk


    getVideoView: (talk) ->
      new Show.Video
        model: talk


    getTitleView: (talk) ->
      new Show.Title
        model: talk

    getLayoutView: (talk) ->
      new Show.Layout
        model: talk
