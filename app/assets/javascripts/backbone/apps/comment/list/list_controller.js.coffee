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
      currentUserId = currentUser.get("id")
      if currentUserId != undefined
        currentUserName = currentUser.get("name")
        addComentsView = @getAddCommentsView comments, currentUser

        @listenTo addComentsView, "comment:save", (comment) =>
          text = $("textarea").val()
          talk_id  = comments.talk_id
          name = comment.get("name")
          image = comment.get("image")
          comment = App.request "new:comments:entity", talk_id
          comment.set({content: text})
          comment.set({updated_at_formatted: "1 minute"})
          comment.set({author_name: name})
          comment.set({author_image: image})
          comment.set({talk_id: comments.talk_id})
          $("textarea").val("Add Your Comment")
          comments.unshift(comment)
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
