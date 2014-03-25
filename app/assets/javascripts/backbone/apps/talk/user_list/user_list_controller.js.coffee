@Demo.module "TalkApp.UserTalkList", (UserTalkList, App, Backbone, Marionette, $, _) ->

  class UserTalkList.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id, talks, talk } = options
      # talks = talks
      talks or= App.request "talk:entities", conference_id

      @layout = @getLayoutView talks
      @listenTo @layout, "show", =>
        @talksRegion talks
        @panelRegion conference_id

      @listenTo @layout, "created", ->
        console.log "talk is created"

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

      # App.vent.on "talk:created", (talk) ->
      #   talk = talk
      #   window.talkk = talk
      #   console.log "created"
      #   @listenTo talk, "created", ->
      #     console.log "created here"


      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        App.vent.trigger "talk:single:render", args.model


      # @listenTo talks, "model:created", (talk) ->
      #   console.log "created here"

      @show talksView, region: @layout.talksRegion



    getTalksView: (talks) ->
      new UserTalkList.Talks
        collection: talks

    getPanelView: ->
      new UserTalkList.Panel

    getLayoutView: ->
      new UserTalkList.Layout
