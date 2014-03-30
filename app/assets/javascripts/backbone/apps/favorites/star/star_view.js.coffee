
@Demo.module "FavoritesApp.GetStar", (GetStar, App, Backbone, Marionette, $, _) ->

  class GetStar.Layout extends App.Views.Layout
    template: "favorites/star/star_layout"

    regions:
      starRegion   :   "#star"


  class GetStar.Star extends App.Views.ItemView
    template: "favorites/star/star"

    triggers:
      "click span.glyphicon-star-empty"   : "fav:clicked"
      "click span.glyphicon-star"         : "ulfav:clicked"

  class GetStar.UnStar extends App.Views.ItemView
    template: "favorites/star/unstar"

    triggers:
      "click span.glyphicon-star-empty"   : "fav:clicked"
      "click span.glyphicon-star"         : "ulfav:clicked"
