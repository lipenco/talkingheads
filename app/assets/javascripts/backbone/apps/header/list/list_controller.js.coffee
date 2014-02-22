@Demo.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _ ) ->

  List.Controller =

    listHeader: ->
      headerView = @getHeaderView()
      App.headerRegion.show headerView

    getHeaderView: ->
      console.log "list"
      new List.Header
