@Demo.module "TalkApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id } = options
      id = conference_id
      talk = App.request "new:talk:entity", id

      @listenTo talk, "created", ->
        console.log "created"
        id = talk.conference_id
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
