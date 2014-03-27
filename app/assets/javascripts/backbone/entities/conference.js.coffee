@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Talk extends App.Entities.Model

    initialize: (@conference_id, @talk_id) ->

    url: -> "/conferences/#{@conference_id}/talks/#{@talk_id or ""}"


  class Entities.TalkCollection  extends App.Entities.Collection

    model: Entities.Talk
    initialize: (@id) ->

    url: -> "/conferences/#{@id}/talks"



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


  class Entities.UserListCollection extends Entities.Collection
    model: Entities.Conference
    url: -> '/user_list'



  class Entities.FavoritesCollection extends Entities.Collection
    model: Entities.Talk
    url: -> '/favourites'



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


    getTalk: (conference_id, talk_id) ->
      talk = new Entities.Talk(conference_id, talk_id)
        # conference_id: id
        # id: talk_id
      talk.fetch()
      talk


    getTalks:(id) ->
      talks = new Entities.TalkCollection(id)
        # id: id
      talks.fetch
        reset: true
        # id: id
      talks

    getFavorites: ->
      favorites = new Entities.FavoritesCollection
      favorites.fetch
        reset: true
      favorites



    getCurrentUserList: ->
      user_list = new Entities.UserListCollection
      user_list.fetch
        reset: true
      user_list


    newSingle: ->
      new Entities.Conference

    newTalk: (id) ->
      new Entities.Talk(id)


  App.reqres.setHandler "favorites:entities", ->
    API.getFavorites()

  App.reqres.setHandler "user_list:entities", ->
    API.getCurrentUserList()


  App.reqres.setHandler "conference:entities", ->
    API.getConferences()


  App.reqres.setHandler "conference:entity", (id) ->
    API.getSingle id

  App.reqres.setHandler "new:conference:entity", ->
    API.newSingle()

  # App.reqres.setHandler "new:talk:entity", (conference_id) ->
  #   API.getSingle(conference_id)

  App.reqres.setHandler "talk:entities", (conference_id) ->
    API.getTalks(conference_id)

  App.reqres.setHandler "new:talk:entity", (id) ->
    API.newTalk(id)

  App.reqres.setHandler "talk:entity", (conference_id, talk_id) ->
    API.getTalk(conference_id, talk_id)
