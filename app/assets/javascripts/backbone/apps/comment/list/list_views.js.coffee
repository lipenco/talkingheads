@Demo.module "CommentApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "comment/list/list_layout"

    regions:
      commentsRegion:     "#commentss-region"
      addComentRegion:    "#add-comments-region"


  class List.AddComment extends App.Views.ItemView
    template: "comment/list/_add"
    className: 'comment_li'
    tagName: "li"

    events:
      "click #contentible" : 'saveComment'

    saveComment: (e) =>
      model = @.model
      @trigger "comment:save", (model)



  class List.Comment extends App.Views.ItemView
    template: "comment/list/_comment"
    className: 'comment_li'
    tagName: "li"



  class List.Comments extends App.Views.CompositeView
    template: "comment/list/_comments"
    itemViewContainer: "ul"
    itemView: List.Comment


    appendHtml: (cv, iv) ->
      cv.$el.prepend iv.el
