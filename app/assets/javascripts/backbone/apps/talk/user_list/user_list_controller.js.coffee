@Demo.module "TalkApp.UserTalkList", (UserTalkList, App, Backbone, Marionette, $, _) ->

  class UserTalkList.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id, talks, talk } = options
      # talks = talks
      talks or= App.request "talk:entities", conference_id

      @listenTo talks, "model:created", (talk) ->
        console.log "from userlist event"

      @layout = @getLayoutView talks

      @listenTo @layout, "show", =>
        @talksRegion talks

      @show @layout, loading: true


    talksRegion: (talks) ->
      talksView = @getTalksView talks

      @listenTo talksView, "childview:talk:single:render", (child, args) ->
        App.vent.trigger "talk:single:render", args.model

      @listenTo talksView, "childview:talk:edit:clicked", (child, args) ->
        talk = child.model
        talk_id = child.model.id
        conference_id = child.model.conference_id
        App.vent.trigger "talk:edit:clicked", conference_id, talk_id, talk


      @show talksView, region: @layout.talksRegion



    getTalksView: (talks) ->
      new UserTalkList.Talks
        collection: talks


    getLayoutView: ->
      new UserTalkList.Layout
