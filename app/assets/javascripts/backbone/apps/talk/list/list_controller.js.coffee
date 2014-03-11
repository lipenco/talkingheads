@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      talks = App.request "talk:entities"
      App.execute "when:fetched", talks, =>

        @layout = @getTalksLayoutView()

        @listenTo @layout, "show", =>
          @listPanel talks
          @talksRrgion talks

        App.talkRegion.show @layout


  		listPanel: (talks) ->
  			panelView = @getPanelView talks
  			@layout.panelRegion.show panelView

  		talksRrgion: (talks) ->
  			talksView = @getTalksView talks
  			@layout.talksRegion.show talksView

  		getTalksView: (talks) ->
  			new List.Talks
  				collection: talks

  		getPanelView: (talks) ->
  			new List.Panel
  				collection: talks

  		getTalksLayoutView: (talks) ->
  			new List.Layout
          collection: talks
