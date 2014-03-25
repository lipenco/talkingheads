@Demo.module "ConferenceApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: ->
      meny.close()
      App.talksListRegion.close()
      App.formRegion.close()
      App.titleRegion.close()
      conferences = App.request "conference:entities"

      # App.execute "when:fetched", conferences, =>

      @layout = @getLayoutView conferences

      @listenTo @layout, "close", @close

      @listenTo @layout, "show", =>
        @titleRegion()
        @panelRegion()
        @conferenceRegion conferences

      @show @layout, loading: true


    titleRegion: ->
      titleView = @getTitleView()
      # @layout.titleRegion.show titleView
      @show titleView, region: @layout.titleRegion

    panelRegion: ->
      panelView = @getPanelView()
      @show panelView, region: @layout.panelRegion
      # @layout.panelRegion.show panelView



    conferenceRegion: (conferences) ->
      conferenceView = @getConferenceView conferences

      @listenTo conferenceView, "childview:conference:single:details", (child, args) ->
        App.vent.trigger "conference:single:details", args.model


      # @layout.conferenceRegion.show conferenceView
      @show conferenceView, region: @layout.conferenceRegion


    getConferenceView: (conferences) ->
      new List.Conference
        collection: conferences

    getPanelView: ->
      new List.Panel

    getTitleView: ->
      new List.Title

    getLayoutView: (conferences) ->
      new List.Layout
        collection: conferences
