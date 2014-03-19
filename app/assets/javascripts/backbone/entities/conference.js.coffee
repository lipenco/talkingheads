@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Talk extends App.Entities.Model

    url: -> Routes.conference_talk_path( this.get("conference_id") , this.get("id") )



  class Entities.TalkCollection  extends App.Entities.Collection

    model: Entities.Talk


    initialize: (@id) ->
    url: -> Routes.conference_talks_path(@id)


  class Entities.Conference extends App.Entities.Model
    urlRoot: -> Routes.conferences_path()

    relations : [
          type: Backbone.Many,
          key : 'talks',
          relatedModel : Entities.Talk
          ]



  class Entities.ConferenceCollection extends App.Entities.Collection
    model: Entities.Conference

    url: -> Routes.conferences_path()



  API =
    getConferences: ->
      conferences = new Entities.ConferenceCollection
      conferences.fetch
        reset: true
      conferences

    getSingle: (id) ->
      single = new Entities.Conference
        id: id
      single.fetch()
      single


    getTalk: (id, talk_id) ->
      talk = new Entities.Talk
        conference_id: id
        id: talk_id
      talk.fetch()
      talk


    getTalks:(id) ->
      talks = new Entities.TalkCollection(id)
        # id: id
      talks.fetch
        reset: true
        # id: id
      talks


    newSingle: ->
      new Entities.Conference

    newTalk: (id) ->
      console.log id
      new Entities.Talk(id)
        # id: id


  App.reqres.setHandler "conference:entities", ->
    API.getConferences()


  App.reqres.setHandler "conference:entity", (id) ->
    API.getSingle id

  App.reqres.setHandler "new:conference:entity", ->
    API.newSingle()

  App.reqres.setHandler "new:talk:entity", (id) ->
    API.newTalk(id)

  App.reqres.setHandler "talk:entities", (id) ->
    # window.is = id
    API.getTalks(id)

  App.reqres.setHandler "talk:entity", (id, talk_id) ->
    API.getTalk(id, talk_id)
