@Demo.module "TalkApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Application

    initialize: (options) ->
      {talks, conference_id } = options
      id = conference_id
      talk = App.request "new:talk:entity", id

      @listenTo talk, "created", ->
        console.log "created"
        id = talk.conference_id
        # App.execute "talk:edit:list", id
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
