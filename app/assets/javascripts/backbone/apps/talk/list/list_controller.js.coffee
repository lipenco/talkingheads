@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->
  
  class List.Controller extends App.Controllers.Base
    
    initialize: ->
      talks = App.request "talk:entities"
    
      App.execute "when:fetched", talks, =>
        
        @layout = @getLayoutView talks
        
        @listenTo @layout, "close", @close
      
        @listenTo @layout, "show", =>
          @titleRegion()
          @panelRegion()
          @talkRegion talks
      
        @show @layout

    
    titleRegion: ->
      titleView = @getTitleView()
      @layout.titleRegion.show titleView
    
    panelRegion: ->
      panelView = @getPanelView()
      
      @listenTo panelView, "new:talk:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView
    
    newRegion: ->
      App.execute "new:talk:single", @layout.newRegion
    
    talkRegion: (talks) ->
      talkView = @gettalkView talks
      
      // @listenTo conferenceView, "childview:conference:single:edit", (child, args) ->
      //   App.vent.trigger "conference:single:edit", args.model

      // @listenTo conferenceView, "childview:conference:single:details", (child, args) ->
      //   App.vent.trigger "conference:single:details", args.model
      
      // @listenTo conferenceView, "childview:conference:delete:clicked", (child, args) ->
      //   model = args.model
      //   if confirm "Are you sure you want to delete #{model.get("name")}?" then model.destroy() else false
      
      @layout.talkRegion.show talkView

    
    getTalkView: (talks) ->
      new List.Talk
        collection: talks
    
    getPanelView: ->
      new List.Panel
    
    getTitleView: ->
      new List.Title
    
    getLayoutView: (talks) ->
      new List.Layout
        collection: talks


