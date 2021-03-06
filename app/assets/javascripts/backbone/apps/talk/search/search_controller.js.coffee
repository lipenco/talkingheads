@Demo.module "TalkApp.Search", (Search, App, Backbone, Marionette, $, _) ->

  class Search.Controller extends App.Controllers.Application

    initialize: (options) ->
      { q } = options
      talks = App.request "search:talk:entities", (q)
      meny.close()
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()

      @layout = @getLayoutView talks

      @listenTo @layout, "show", =>
        @talksRegion talks

      @show @layout, loading: true


    talksRegion: (talks) ->
      talksView = @getTalksView talks

      @listenTo talksView, "query:get", (q) =>
        # talks = App.request "search:talk:entities", (q)
        # @talksRegion talks
        App.vent.trigger "list:searched:talks", q


      @listenTo talksView, "childview:talk:single:clicked", (child, args) ->
        model = args.model
        id = model.get("conference_id")
        talk_id = model.get("id")
        App.vent.trigger "talk:single:clicked", id, talk_id, args.model

      @layout.talksRegion.show talksView


    getTalksView: (talks) ->
      new Search.Talks
        collection: talks


    getLayoutView: (talks) ->
      new Search.Layout
        collection: talks
