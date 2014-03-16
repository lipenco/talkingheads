@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
        { id, talk_id, talk } = options
        talk or= App.request "talk:entity", id, talk_id
        talks = App.request "talk:entities", id

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
        childview = child.$el
        @manageHighlight(childview)

      @layout.talksRegion.show talksView


    titleRegion: (talk) ->
      titleView = @getTitleView talk
      @layout.titleRegion.show titleView

    videoRegion: (talk) ->
      videoView = @getVideoView talk
      @layout.videoRegion.show videoView
      video = talk.get("video_url")

      pop = Popcorn.youtube( "#youtube", "#{video}" )


    manageHighlight: (childview) ->
      window.view = childview
      @currentActiveView.removeHighlight() if @currentActiveView
      @currentActiveView = childview
      @highlight(childview)

    removeHighlight: ->
      @$el.removeClass('highlight')
      # @render()

    highlight: (childview) ->
      childview.addClass('highlight')
      console.log childview
      # @render()




    nextRegion: (talk) ->
      nextView = @getNextView talk
      @layout.nextRegion.show nextView



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
