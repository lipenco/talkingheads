@Demo.module "CommentApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->
      { talk } = options
      talk_id = talk.id
      comments = App.request "comments:entities", talk_id
      @layout = @getLayoutView comments

      @listenTo @layout, "show", =>
        @commentsRegion comments
        @addComentRegion comments

      @show @layout, loading: true


    commentsRegion: (comments) ->
      commentsView = @getCommentsView comments
      @show commentsView, region: @layout.commentsRegion

    addComentRegion: (comments) ->
      currentUser = App.request "get:current:user"
      currentUserName = currentUser.get("name")
      addComentsView = @getAddCommentsView comments, currentUser
      @show addComentsView, region: @layout.addComentRegion


    getAddCommentsView: (comments, currentUser) ->
      new List.AddComment
        collection: comments
        model: currentUser


    getCommentsView: (comments) ->
      new List.Comments
        collection: comments


    getLayoutView: (comments) ->
      new List.Layout
        collection: comments
