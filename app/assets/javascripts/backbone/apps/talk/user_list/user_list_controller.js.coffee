@Demo.module "TalkApp.UserTalkList", (UserTalkList, App, Backbone, Marionette, $, _) ->

  class UserTalkList.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id, talks } = options
      # talks = talks
      talks or= App.request "talk:entities", conference_id

      @layout = @getLayoutView talks

      @listenTo @layout, "show", =>
        @talksRegion talks
        @panelRegion conference_id

      @show @layout, loading: true



    panelRegion: (conference_id) ->
      panelView = @getPanelView()
      @listenTo panelView, "new:talk:button:clicked", =>
        @newRegion(conference_id)

      @show panelView, region: @layout.panelRegion

    newRegion:(conference_id) ->

      App.execute "new:talk:single", conference_id, @layout.newRegion


    talksRegion: (talks) ->
      talksView = @getTalksView talks

      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        App.vent.trigger "talk:single:render", args.model

      @show talksView, region: @layout.talksRegion



    getTalksView: (talks) ->
      new UserTalkList.Talks
        collection: talks

    getPanelView: ->
      new UserTalkList.Panel

    getLayoutView: ->
      new UserTalkList.Layout
