@Demo.module "TalkApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id } = options
      talk = App.request "new:talk:entity", conference_id

      @listenTo talk, "created", ->
        @region.close()
        # console.log "created"
        # App.execute "new:talk:added", @talksRegion
        App.vent.trigger "talk:created", talk

      newView = @getNewView talk
      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (talk) ->
      new New.Talk
        model: talk
