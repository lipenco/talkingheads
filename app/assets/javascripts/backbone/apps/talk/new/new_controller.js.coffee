@Demo.module "TalkApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id } = options
      talk = App.request "new:talk:entity", conference_id

      @listenTo talk, "created", ->
        console.log "created"
        id = talk.conference_id
        # App.vent.trigger "talk:created", talk
        App.execute "talk:edit:list", id
        @region.close()

      newView = @getNewView talk
      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (talk) ->
      new New.Talk
        model: talk
