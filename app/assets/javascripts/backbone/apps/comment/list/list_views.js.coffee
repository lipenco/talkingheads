@Demo.module "CommentApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "comment/list/list_layout"

    regions:
      commentsRegion:     "#comments-region"
      addComentRegion:    "#add-comments-region"


  class List.AddComment extends App.Views.ItemView
    template: "comment/list/_add"

    events:
      "click #contentible" : 'saveComment'

    saveComment: (e) =>
      console.log "sa"
      model = @.model
      @trigger "comment:save", (model)





  class List.Comment extends App.Views.ItemView
    template: "comment/list/_comment"
    className: 'comment_li'
    tagName: "li"

  class List.Empty extends App.Views.ItemView
    template: "comment/list/_empty"
    tagName: "li"


  class List.Comments extends App.Views.CompositeView
    template: "comment/list/_comments"
    itemView: List.Comment
    emptyView: List.Empty
    itemViewContainer: "ul"
