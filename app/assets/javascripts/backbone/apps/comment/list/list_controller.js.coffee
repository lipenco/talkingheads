@Demo.module "CommentApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Application

    initialize: (options) ->
      { talk } = options
      id = talk.id
      comments = App.request "comment:entities", id

      @layout = @getLayoutView comments

      @listenTo @layout, "show", =>
        @commentsRegion comments

      @show @layout, loading: true


    commentsRegion: (comments) ->
      commentsView = @getCommentsView comments
      @show commentsView, region: @layout.commentsRegion


    getCommentsView: (comments) ->
      new List.Comments
        collection: comments


    getLayoutView: (comments) ->
      new List.Layout
        collection: comments
