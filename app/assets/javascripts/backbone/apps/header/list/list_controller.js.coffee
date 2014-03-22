@Demo.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller =

    listHeader: ->
      currentUser = App.request "get:current:user"
      currentUserName = currentUser.get("name")
      window.uss = currentUserName
      links = App.request "header:entities", (currentUserName)

      headerView = @getHeaderView links
      App.headerRegion.show headerView


    getHeaderView: (links, currentUserName) ->
      new List.Headers
        collection: links
