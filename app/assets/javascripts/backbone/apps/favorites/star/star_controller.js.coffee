@Demo.module "FavoritesApp.GetStar", (GetStar, App, Backbone, Marionette, $, _) ->

  class GetStar.Controller extends App.Controllers.Application

    initialize: (options)->
      {talk} = options
      currentUser = App.request "get:current:user"
      favorites = currentUser.get("favourites")
      favorites = _.pluck(favorites, 'talk_id')

      @layout = @getLayoutView favorites

      @listenTo @layout, "show", =>
        @starRegion() if talk.id in favorites
        @unstarRegion() unless talk.id in favorites

      @show @layout, loading: true

    starRegion: ->
      starView = @getStarView()
      @show starView , region: @layout.starRegion

    unstarRegion: ->
      unstarView = @getUnstarView()
      @show unstarView , region: @layout.starRegion

      # if talk.id in favorites
      #   @starView = @getStarView favorites
      # else
      #   @starView = @getUnStarView favorites
      #
      # @listenTo @starView, "fav:clicked", (el) ->
      #   el.view.$el.find(".mark-fav").removeClass("glyphicon-star-empty").addClass("glyphicon-star")
      #
      # @listenTo @starView, "ulfav:clicked", (el) ->
      #   el.view.$el.find(".mark-fav").removeClass("glyphicon-star").addClass("glyphicon-star-empty")
      #
      # @show @starView, loading: true

    getLayoutView: ->
      new GetStar.Layout


    getStarView: ->
      new GetStar.Star

    getUnstarView: ->
      new GetStar.UnStar
