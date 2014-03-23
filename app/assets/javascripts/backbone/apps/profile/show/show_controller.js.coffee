@Demo.module "ProfileApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: ->
      currentUser = App.request "get:current:user"
      currentUserId = currentUser.get("id")
      window.u = currentUserId

      # if currentUserName == undefined

      @layout = @getLayoutView currentUser

      @listenTo @layout, "show", =>
        @nameRegion currentUser
        @loginRegion() if currentUserId is undefined
        @panelRegion() if currentUserId

        # @logoutRegion currentUserName

      # @show @layout, loading: true
      App.menyRegion.show @layout

    panelRegion: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:conference:button:clicked", =>
        @newRegion()

      @show panelView, region: @layout.panelRegion

    loginRegion: ->
      loginView = @getLoginView()
      @layout.loginRegion.show loginView

    newRegion: ->
      App.execute "new:conference:single", @layout.newRegion


    nameRegion: (currentUser) ->
      nameView = @getNameView currentUser
      @layout.nameRegion.show nameView


    getPanelView: ->
      new Show.Panel

    getLoginView: ->
      new Show.Login


    getNameView: (currentUser)  ->
      new Show.Name
        model: currentUser

    getLayoutView: ->
      new Show.Layout
