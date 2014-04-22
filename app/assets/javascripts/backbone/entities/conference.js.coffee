@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Comment extends App.Entities.Model
    initialize: (@talk_id, @comment_id) ->
    url: -> "/talks/#{@talk_id}/comments/#{@comment_id or ""}"


  class Entities.CommentCollection  extends App.Entities.Collection
    model: Entities.Comment
    initialize: (@talk_id) ->
    url: -> "/talks/#{@talk_id}/comments"


  class Entities.Talk extends App.Entities.Model

    initialize: (@conference_id, @talk_id) ->

    url: -> "/conferences/#{@conference_id}/talks/#{@talk_id or ""}"


  class Entities.TalkCollection  extends App.Entities.Collection
    model: Entities.Talk
    initialize: (@id) ->
    url: -> "/conferences/#{@id}/talks"

    relations : [
          type: Backbone.Many,
          key : 'comments',
          relatedModel : Entities.Comment
          ]


  class Entities.TalkSearchCollection  extends App.Entities.Collection
    model: Entities.Talk
    initialize: (@q) ->
    url: -> "/search/#{@q}"



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


  class Entities.FavoritesCollection extends Entities.Collection
    # model: Entities.Talk
    url: -> '/favourites'

  class Entities.Favorites extends App.Entities.Model
    initialize: (@talk_id) ->
    url: -> "/talks/#{@talk_id}/favorites"


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
      talks

    getSearchedTalks:(q) ->
      talks = new Entities.TalkSearchCollection(q)
      talks.fetch
        reset: true
      talks

    getComments: (talk_id) ->
      comments = new Entities.CommentCollection(talk_id)
      comments.fetch
        reset: true
      comments

    getFavorites: ->
      favorites = new Entities.FavoritesCollection
      favorites.fetch
        reset: true
      favorites

    newSingle: ->
      new Entities.Conference

    newTalk: (id) ->
      new Entities.Talk(id)

    setNewFavorites: (talk_id) ->
      new Entities.Favorites(talk_id)


  App.reqres.setHandler "favorites:entities", ->
    API.getFavorites()

  App.reqres.setHandler "conference:entities", ->
    API.getConferences()


  App.reqres.setHandler "conference:entity", (id) ->
    API.getSingle id

  App.reqres.setHandler "new:conference:entity", ->
    API.newSingle()

  App.reqres.setHandler "search:talk:entities", (q)->
    API.getSearchedTalks(q)


  App.reqres.setHandler "talk:entities", (conference_id) ->
    API.getTalks(conference_id)

  App.reqres.setHandler "comments:entities", (talk_id) ->
    API.getComments(talk_id)

  App.reqres.setHandler "new:talk:entity", (id) ->
    API.newTalk(id)

  App.reqres.setHandler "talk:entity", (conference_id, talk_id) ->
    API.getTalk(conference_id, talk_id)

  App.reqres.setHandler "new:favorite:entity", (user_id, talk_id) ->
    API.setNewFavorites(user_id, talk_id)
