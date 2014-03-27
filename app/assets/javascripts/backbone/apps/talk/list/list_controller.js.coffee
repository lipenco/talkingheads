@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->
      { single, id } = options
      single or= App.request "conference:entity", id
      meny.close()
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()


      @layout = @getLayoutView single

      @listenTo @layout, "show", =>
        @talksRegion single

      @show @layout, loading: true




    talksRegion: (single) ->
      talksView = @getTalksView single

      @listenTo talksView, "childview:talk:single:clicked", (child, args) ->
        model = args.model
        id = model.get("conference_id")
        talk_id = model.get("id")
        App.vent.trigger "talk:single:clicked", id, talk_id, args.model

      # @listenTo talksView, "childview:talk:delete:clicked", (child, args) ->
      #   model = args.model
      #   if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy(model.id) else false


      @layout.talksRegion.show talksView


    getTalksView: (single) ->
      window.single = single
      talks = single.get("talks")
      new List.Talks
        collection: talks


    getLayoutView: (single) ->
      talks = single.get("talks")
      new List.Layout
        collection: talks
