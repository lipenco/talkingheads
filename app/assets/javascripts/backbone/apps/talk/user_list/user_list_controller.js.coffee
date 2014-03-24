@Demo.module "TalkApp.UserTalkList", (UserTalkList, App, Backbone, Marionette, $, _) ->

  class UserTalkList.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id, talks } = options
      talks = talks

      @layout = @getLayoutView talks

      @listenTo @layout, "show", =>
        @talksRegion talks

      @show @layout, loading: true


    talksRegion: (talks) ->
      talksView = @getTalksView talks

      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        App.vent.trigger "talk:single:render", args.model

      @show talksView, region: @layout.talksRegion



    getTalksView: (talks) ->
      new UserTalkList.Talks
        collection: talks


    getLayoutView: ->
      new UserTalkList.Layout
