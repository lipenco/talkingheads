@Demo.module "ConferenceApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Application

    initialize: (options) ->
      { conferences, id } = options
      conferences or= App.request "conference:entity", id
      meny.close()

      @listenTo conferences, "updated", ->
        App.vent.trigger "conference:updated", conferences

      # App.execute "when:fetched", conferences, =>
      @layout = @getLayoutView conferences

      @listenTo @layout, "show", =>
        @titleRegion conferences
        @formRegion conferences
        @panelRegion conferences

      @show @layout, loading: true

    titleRegion: (conferences) ->
      titleView = @getTitleView conferences
      @show titleView, region: @layout.titleRegion
      # @layout.titleRegion.show titleView

    panelRegion: (conferences) ->
      panelView = @getPanelView()
      @listenTo panelView, "new:talk:button:clicked", =>
        @newRegion(conferences)

      @show panelView, region: @layout.panelRegion

    newRegion: (conferences) ->
      conference_id = conferences.id
      App.execute "new:talk:single", conference_id, @layout.newRegion


    formRegion: (conferences) ->
      editView = @getEditView conferences

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "conference:cancelled", conferences

      @listenTo editView, "conference:delete:clicked", (conferences) ->
        model = conferences.model
        if confirm "Are you sure you want to delete #{model.get("name")} and all the talks?" then model.destroy(model.id) else false
        App.vent.trigger "conference:cancelled", conferences

      formView = App.request "form:wrapper", editView

      # @layout.formRegion.show
      @show formView, region: @layout.formRegion

    getTitleView: (conferences) ->
      new Edit.Title
        model: conferences

    getLayoutView: (conferences) ->
      new Edit.Layout
        model: conferences

    getPanelView: ->
      new Edit.Panel

    getEditView: (conferences) ->
      new Edit.Conference
        model: conferences
