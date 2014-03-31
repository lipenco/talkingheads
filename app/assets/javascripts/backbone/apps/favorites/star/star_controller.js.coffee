@Demo.module "FavoritesApp.GetStar", (GetStar, App, Backbone, Marionette, $, _) ->

  class GetStar.Controller extends App.Controllers.Application

    initialize: (options)->
      {talk} = options

      # currentUser = App.request "get:current:user"
      # favorites = currentUser.get("favourites")
      # favorites = _.pluck(favorites, 'talk_id')
      # talk_id = talk.id

      @layout = @getLayoutView talk

      @listenTo @layout, "show", =>
        @starRegion(talk) if talk.get("favorited") == true
        @unstarRegion(talk) unless talk.get("favorited") == true

      @show @layout, loading: true

    starRegion:(talk) ->
      starView = @getStarView()

      @listenTo starView, "ulfav:clicked", (el) ->
        talk.set("favorited", false)
        window.wt = talk
        @unstarRegion(talk)
        talk_id = talk.id
        $.ajax
          method: 'DELETE',
          url: "talks/#{talk_id}/favorites"

      @show starView , region: @layout.starRegion

    unstarRegion:(talk) ->
      unstarView = @getUnstarView()

      @listenTo unstarView, "fav:clicked", (el) ->
        talk.set("favorited", true)
        talk_id = talk.id
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
