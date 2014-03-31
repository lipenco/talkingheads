@Demo.module "FavoritesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: ->
      currentUser = App.request "get:current:user"
      currentUserId = currentUser.get("id")
      favorites = App.request "favorites:entities" if currentUserId
      meny.close()
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()

      @layout = @getLayoutView favorites

      @listenTo @layout, "show", =>
        @talksRegion favorites

      @show @layout, loading: true

    talksRegion: (favorites) ->
      talksView = @getTalksView favorites

      @listenTo talksView, "childview:talk:single:clicked", (child, args) ->
        model = args.model
        id = model.get("conference_id")
        talk_id = model.get("id")
        window.mm = model
        App.vent.trigger "talk:single:clicked", id, talk_id, model

      @layout.talksRegion.show talksView


    getTalksView: (favorites) ->
      new List.Talks
        collection: favorites


    getLayoutView: (favorites)->
      new List.Layout
        collection: favorites
