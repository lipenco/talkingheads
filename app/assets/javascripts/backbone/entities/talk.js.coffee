@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  
  class Entities.Talk extends App.Entities.Model
    urlRoot: -> Routes.conference_talks_path()
  
  class Entities.TalkCollection extends App.Entities.Collection
    model: Entities.Talk
    
    url: -> Routes.conference_talks_path()
  
  API =
    getTalks: ->
      talks = new Entities.TalkCollection
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
  
  App.reqres.setHandler "talk:entities", ->
    API.getTalks()
  
  App.reqres.setHandler "talk:entity", (id) ->
    API.getTalk id
  
  App.reqres.setHandler "new:talk:entity", ->
    API.newTalk()

