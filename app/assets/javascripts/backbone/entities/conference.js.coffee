@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Talk extends App.Entities.Model

    url: -> Routes.conference_talk_path( this.get("conference_id") , this.get("id") )



  class Entities.TalkCollection extends App.Entities.Collection
    model: Entities.Talk

    url: -> Routes.conference_talks_path()



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

    getTalks: (id) ->
      talks = new Entities.TalkCollection
        id: id
      talks.fetch
        reset: true
      talks


    newSingle: ->
      new Entities.Conference

  App.reqres.setHandler "conference:entities", ->
    API.getConferences()


  App.reqres.setHandler "conference:entity", (id) ->
    API.getSingle id

  App.reqres.setHandler "new:conference:entity", ->
    API.newSingle()

  App.reqres.setHandler "talk:entities", (id) ->
    API.getTalks(id)
