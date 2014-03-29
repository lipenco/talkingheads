@Demo.module "FavoritesApp.GetStar", (GetStar, App, Backbone, Marionette, $, _) ->

  class GetStar.Controller extends App.Controllers.Application

    initialize: (options)->
      {talk} = options
      currentUser = App.request "get:current:user"
      currentUserId = currentUser.get("id")
      favorites = App.request "favorites:entities" if currentUserId
      meny.close()
      # App.talksListRegion.close()
      # App.formRegion.close()
      # App.titleRegion.close()

      @starView = @getStarView favorites

      @listenTo @starView, "fav:clicked", (el) ->
        el.view.$el.find(".mark-fav").removeClass("glyphicon-star-empty").addClass("glyphicon-star")

      @listenTo @starView, "ulfav:clicked", (el) ->
        el.view.$el.find(".mark-fav").removeClass("glyphicon-star").addClass("glyphicon-star-empty")

      @show @starView, loading: true


    getStarView: (favorites)->
      new GetStar.Star
        collection: favorites
