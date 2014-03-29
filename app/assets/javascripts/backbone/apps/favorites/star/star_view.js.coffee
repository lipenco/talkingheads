
@Demo.module "FavoritesApp.GetStar", (GetStar, App, Backbone, Marionette, $, _) ->

  class GetStar.Star extends App.Views.Layout
    template: "favorites/star/star"

    triggers:
      "click span.glyphicon-star-empty"   : "fav:clicked"
      "click span.glyphicon-star"         : "ulfav:clicked"
