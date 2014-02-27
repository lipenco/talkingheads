@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  
  class Entities.Conference extends App.Entities.Model
    urlRoot: -> Routes.conferences_path()
  
  class Entities.ConferenceCollection extends App.Entities.Collection
    model: Entities.Conference
    
    url: -> Routes.conferences_path()
  
  API =
    getConferences: ->
      conferences = new Entities.ConferenceCollection
      conferences.fetch
        reset: true
      conferences
    
    getConference: (id) ->
      conference = new Entities.Conference
        id: id
      conference.fetch()
      conference
    
    newConference: ->
      new Entities.Conference
  
  App.reqres.setHandler "conference:entities", ->
    API.getConferences()
  
  App.reqres.setHandler "conference:entity", (id) ->
    API.getConference id
  
  App.reqres.setHandler "new:conference:entity", ->
    API.newConference()

