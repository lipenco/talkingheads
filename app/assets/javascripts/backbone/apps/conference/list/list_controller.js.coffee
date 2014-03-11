@Demo.module "ConferenceApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      conferences = App.request "conference:entities"

      App.execute "when:fetched", conferences, =>
        @layout = @getLayoutView conferences

        @listenTo @layout, "close", @close

        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion()
          @conferenceRegion conferences

        @show @layout


    titleRegion: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView

    panelRegion: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:conference:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    newRegion: ->
      App.execute "new:conference:single", @layout.newRegion

    conferenceRegion: (conferences) ->
      conferenceView = @getConferenceView conferences

      @listenTo conferenceView, "childview:conference:single:edit", (child, args) ->
        App.vent.trigger "conference:single:edit", args.model

      @listenTo conferenceView, "childview:conference:single:details", (child, args) ->
        App.vent.trigger "conference:single:details", args.model

      @listenTo conferenceView, "childview:conference:delete:clicked", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get("name")}?" then model.destroy() else false

      @layout.conferenceRegion.show conferenceView


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
