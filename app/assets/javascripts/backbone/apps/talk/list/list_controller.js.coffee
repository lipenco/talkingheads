@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conference_id, talks } = options
      talks = talks

      @layout = @getLayoutView talks

      @listenTo @layout, "show", =>
        @talksRegion talks

      @show @layout, loading: true


    talksRegion: (talks) ->
      talksView = @getTalksView talks
      @show talksView, region: @layout.talksRegion



    getTalksView: (talks) ->
      new List.Talks
        collection: talks


    getLayoutView: ->
      new List.Layout
