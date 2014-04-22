@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: (options) ->
      { id, talk_id, talk } = options
      if talk
        App.request "talk:entity", id, talk_id
      else
        talk = App.request "talk:entity", id, talk_id
      talks = App.request "talk:entities", id
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()

      @layout = @getLayoutView talk

      @listenTo @layout, "show", =>
        @titleRegion talk
        @videoRegion talk
        @talksRegion talks, talk
        @starRegion talk
        @speakerRegion talk
        @descriptionRegion talk
        @commentsRegion talk

      @show @layout, loading: true



    talksRegion: (talks, talk) ->
      talksView = @getTalksView talks, talk


      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        @starRegion args.model
        @titleRegion args.model
        @videoRegion args.model
        @speakerRegion args.model
        @descriptionRegion args.model
        @commentsRegion args.model
        childview = child.$el
        @manageHighlight(childview)
        id = args.model.get("id")
        conference_id = args.model.get("conference_id")
        App.vent.trigger "talk:single:rendered", conference_id, id


      # @layout.talksRegion.show talksView
      @show talksView, region: @layout.talksRegion, loading: true


    titleRegion: (talk) ->
      titleView = @getTitleView talk
      @layout.titleRegion.show titleView

    descriptionRegion: (talk) ->
      descriptionView = @getDescriptionView talk
      @layout.descriptionRegion.show descriptionView

    # commentsRegion: (talks) ->
    #   commentsView = @getCommentsView talk
    #   @layout.commentsRegion.show commentsView

    speakerRegion: (talk) ->
      speakerView = @getSpeakerView talk
      @layout.speakerRegion.show speakerView

    starRegion: (talk) ->
      App.execute "star:for:talk", talk,  @layout.starRegion

    commentsRegion: (talk) ->
      App.execute "get:talk:comments", talk, @layout.commentsRegion


    videoRegion: (talk) ->
      videoView = @getVideoView talk
      @layout.videoRegion.show videoView
      video = talk.get("video_url")
      if video.match(/youtube/) != null
        pop = Popcorn.youtube( "#youtube", "#{video}" )
      else if video.match(/vimeo/) != null
        pop = Popcorn.vimeo( "#youtube", "#{video}" )




    manageHighlight: (childView) ->
      $("li").removeClass('highlight')
      childView.addClass('highlight')


    getDescriptionView: (talk) ->
      new Show.Description
        model: talk


    getSpeakerView: (talk) ->
      new Show.Speaker
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
