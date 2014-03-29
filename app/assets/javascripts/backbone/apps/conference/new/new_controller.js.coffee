@Demo.module "ConferenceApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: ->
      conference = App.request "new:conference:entity"
      @listenTo conference, "created", ->
        meny.close()
        console.log "created"
        id = conference.id
        App.vent.trigger "conference:created", id, conference


      newView = @getNewView conference
      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (conference) ->
      new New.Conference
        model: conference
