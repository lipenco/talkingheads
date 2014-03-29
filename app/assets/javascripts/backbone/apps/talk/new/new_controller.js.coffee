@Demo.module "TalkApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: (options) ->
      {talks } = options
      conference_id = talks.id
      talk = App.request "new:talk:entity", conference_id
      talk.set("conference_id", conference_id)

      @listenTo talk, "created", ->
        console.log "created"
        @region.close()

      newView = @getNewView talk, talks
      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (talk, talks) ->
      new New.Talk
        model: talk
        collection: talks
