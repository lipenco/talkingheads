@Demo.module "TalkApp.UserTalkList", (UserTalkList, App, Backbone, Marionette, $, _) ->

  class UserTalkList.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id, talks, talk } = options
      # talks = talks
      talks or= App.request "talk:entities", conference_id

      @listenTo talks, "created", (talk) ->
        console.log "from userlist event"

      @layout = @getLayoutView talks

      @listenTo @layout, "show", =>
        @talksRegion talks

      App.headerRegion.show

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



    getTalksView: (talks) ->
      new UserTalkList.Talks
        collection: talks


    getLayoutView: ->
      new UserTalkList.Layout
