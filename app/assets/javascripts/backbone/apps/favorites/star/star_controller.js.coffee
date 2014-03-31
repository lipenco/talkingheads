@Demo.module "FavoritesApp.GetStar", (GetStar, App, Backbone, Marionette, $, _) ->

  class GetStar.Controller extends App.Controllers.Application

    initialize: (options)->
      {talk} = options
      currentUser = App.request "get:current:user"
      favorites = currentUser.get("favourites")
      favorites = _.pluck(favorites, 'talk_id')
      talk_id = talk.id

      @layout = @getLayoutView favorites, talk_id

      @listenTo @layout, "show", =>
        @starRegion(talk_id) if talk.id in favorites
        @unstarRegion(talk_id) unless talk.id in favorites

      @show @layout, loading: true

    starRegion:(talk_id) ->
      starView = @getStarView()

      @listenTo starView, "ulfav:clicked", (el) ->
        @unstarRegion(talk_id)
        $.ajax
          method: 'DELETE',
          url: "talks/#{talk_id}/favorites"

      @show starView , region: @layout.starRegion

    unstarRegion:(talk_id) ->
      unstarView = @getUnstarView()

      @listenTo unstarView, "fav:clicked", (el) ->
        favourite = App.request "new:favorite:entity", talk_id
        favourite.save()
        @starRegion(talk_id)

      @show unstarView , region: @layout.starRegion

    getLayoutView: ->
      new GetStar.Layout

    getStarView: ->
      new GetStar.Star

    getUnstarView: ->
      new GetStar.UnStar
