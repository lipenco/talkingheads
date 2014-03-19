@Demo.module "TalkApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: (region) ->
      id = region.id
      talk = App.request "new:talk:entity", id


      @listenTo talk, "created", ->
        console.log "talk created"
        App.vent.trigger "talk:created", talk

      newView = @getNewView talk
      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (talk, id) ->
      new New.Talk
        model: talk
        id: id
