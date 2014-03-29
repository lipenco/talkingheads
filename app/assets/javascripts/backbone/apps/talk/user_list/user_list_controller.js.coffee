@Demo.module "TalkApp.UserTalkList", (UserTalkList, App, Backbone, Marionette, $, _) ->

  class UserTalkList.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id, talks, talk } = options
      talks or= App.request "talk:entities", conference_id

      @layout = @getLayoutView talks

      @listenTo @layout, "show", =>
        @talksRegion talks
        @panelRegion talks, conference_id

      # App.headerRegion.show

      @show @layout, loading: true


    talksRegion: (talks) ->
      talksView = @getTalksView talks

      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        App.vent.trigger "talk:single:render", args.model

      @listenTo talksView, "childview:talk:edit:clicked", (talk) ->
        talkk = talk.model
        id = talkk.get("conference_id")
        talk_id = talkk.get("id")
        window.talk = talkk
        App.vent.trigger "talk:edit:clickedd", id, talk_id, talkk



      @show talksView, region: @layout.talksRegion



    manageHighlight: (childView) ->
      $("li").removeClass('highlight')
      childView.addClass('highlight')


    panelRegion: (talks) ->
      panelView = @getPanelView(talks)
      @listenTo panelView, "new:talk:button:clicked", =>
        @newRegion(talks)

      @show panelView, region: @layout.panelRegion

    newRegion: (talks) ->
      App.execute "new:talk:single", talks, @layout.newRegion



    getTalksView: (talks) ->
      new UserTalkList.Talks
        collection: talks

    getPanelView: (talks)->
      new UserTalkList.Panel
        collection: talks

    getLayoutView: (talks)->
      new UserTalkList.Layout
        collection: talks
