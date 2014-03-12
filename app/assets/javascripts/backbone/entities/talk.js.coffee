@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Talk extends App.Entities.Model

    relations: [
      type: Backbone.Many
      key: 'talks'
      relatedModel: Entities.Conference
    ]

    url: -> Routes.conference_talk_path()



  class Entities.TalkCollection extends App.Entities.Collection
    model: Entities.Talk

    url: -> Routes.conference_talks_path(1)


  API =
    getTalks: (id)->
      talks = new Entities.TalkCollection
        id: id
      talks.fetch
        reset: true
      talks


    getTalk: (id) ->
      talk = new Entities.Talk
        id: id
      talk.fetch()
      talk

    newTalk: ->
      new Entities.Talk

  App.reqres.setHandler "talk:entities", (id) ->
    API.getTalks id

  App.reqres.setHandler "talk:entity", (id) ->
    API.getTalk id

  App.reqres.setHandler "new:talk:entity", ->
    API.newTalk()
