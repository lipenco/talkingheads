@Demo.module "ProfileApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Application

    initialize: ->
      currentUser = App.request "get:current:user"
      currentUserId = currentUser.get("id")
      user_list = App.request "user_list:entities" if currentUserId

      # if currentUserName == undefined

      @layout = @getLayoutView currentUser

      @listenTo @layout, "show", =>
        @nameRegion currentUser
        @loginRegion() if currentUserId is undefined
        @panelRegion() if currentUserId
        @favRegion() if currentUserId
        @conferencesRegion(user_list) if currentUserId

        # @logoutRegion currentUserName

      # @show @layout, loading: true
      App.menyRegion.show @layout


    conferencesRegion: (user_list) ->
      listView = @getListView user_list

      @listenTo listView, "childview:conference:single:edit", (child, args) ->
        window.child = args
        App.vent.trigger "conference:single:edit", args.model

      @listenTo listView, "childview:conference:single:details", (child, args) ->
        App.vent.trigger "conference:single:details", args.model

      @show listView, region: @layout.conferencesRegion

    panelRegion: ->
      panelView = @getPanelView()

      @listenTo panelView, "new:conference:button:clicked", =>
        @newRegion()

      @show panelView, region: @layout.panelRegion

    favRegion: ->
      favView = @getFavView()
      @show favView , region: @layout.favRegion


    loginRegion: ->
      loginView = @getLoginView()
      @layout.loginRegion.show loginView

    newRegion: ->
      App.execute "new:conference:single", @layout.newRegion


    nameRegion: (currentUser) ->
      nameView = @getNameView currentUser

      @listenTo nameView, "close:button:clicked", ->
        App.vent.trigger "menu:closed"
        meny.close()

      @layout.nameRegion.show nameView


    getPanelView: ->
      new Show.Panel

    getLoginView: ->
      new Show.Login

    getFavView: ->
      new Show.Fav

    getListView: (user_list) ->
      new Show.User_List
        collection: user_list

    getNameView: (currentUser)  ->
      new Show.Name
        model: currentUser

    getLayoutView: ->
      new Show.Layout
