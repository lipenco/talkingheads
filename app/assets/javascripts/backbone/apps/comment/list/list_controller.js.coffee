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

      @listenTo addComentsView, "comment:save", (comment) =>
        text = $("span p").text()
        talk_id  = comments.talk_id
        comment = App.request "new:comments:entity", talk_id
        comment.set({content: text})
        comment.set({talk_id: comments.talk_id})
        # comment.set({user_id: user.id})
        window.tt = comment
        talk_id  = comments.talk_id
        # ticket_id = ticket.id
        # comment.url = "/talks/#{talk_id}/comments"
        comment.save()

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
