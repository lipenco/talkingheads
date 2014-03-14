@Demo.module "ConferenceApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->
  
  class Edit.Controller extends App.Controllers.Base
    
    initialize: (options) ->
      { conferences, id } = options
      conferences or= App.request "conference:entity", id
      
      @listenTo conferences, "updated", ->
        App.vent.trigger "conference:updated", conferences
      
      App.execute "when:fetched", conferences, =>
        @layout = @getLayoutView conferences
        
        @listenTo @layout, "show", =>
          @titleRegion conferences
          @formRegion conferences
      
        @show @layout
    
    titleRegion: (conferences) ->
      titleView = @getTitleView conferences
      @layout.titleRegion.show titleView
    
    formRegion: (conferences) ->
      editView = @getEditView conferences
      
      @listenTo editView, "form:cancel", ->
        App.vent.trigger "conference:cancelled", conferences
      
      formView = App.request "form:wrapper", editView
      
      @layout.formRegion.show formView
    
    getTitleView: (conferences) ->
      new Edit.Title
        model: conferences
    
    getLayoutView: (conferences) ->
      new Edit.Layout
        model: conferences
    
    getEditView: (conferences) ->
      new Edit.Conference
        model: conferences
