@Demo.module "TalkApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Application

    initialize: (options) ->
      {id, talk_id } = options
      talk = App.request "talk:entity", id, talk_id

      @listenTo talk, "updated", ->
        App.vent.trigger "talk:updated", talk

      # App.execute "when:fetched", conferences, =>
      @layout = @getLayoutView talk

      @listenTo @layout, "show", =>
        @titleRegion talk
        @formRegion talk

      @show @layout, loading: true

    titleRegion: (talk) ->
      titleView = @getTitleView talk
      @show titleView, region: @layout.titleRegion


    formRegion: (talk) ->
      editView = @getEditView talk

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "talk:cancelled", talk

      @listenTo editView, "talk:delete:clicked", (talk) ->
        model = talk.model
        if confirm "Are you sure you want to delete #{model.get("title")}?" then model.destroy() else false
        App.vent.trigger "talk:cancelled", talk

      formView = App.request "form:wrapper", editView

      # @layout.formRegion.show
      @show formView, region: @layout.formRegion

    getTitleView: (talk) ->
      new Edit.Title
        model: talk


    getLayoutView: ->
      new Edit.Layout


    getEditView: (talk) ->
      new Edit.Talk
        model: talk
