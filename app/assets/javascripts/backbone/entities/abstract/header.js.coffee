@Demo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Header extends Entities.Model

  class Entities.HeaderCollection extends Entities.Collection
    model: Entities.Header

  API =
    getHeaders: ->
      new Entities.HeaderCollection [
        { name: "Favorites" ,  url: "#favorites", icon:'glyphicon glyphicon-heart' }
        { name: "About",       url: "#about", icon: '' }
        { name: "Sign up" ,      url: "#login", icon: 'glyphicon glyphicon-user'  }
      ]

  App.reqres.setHandler "header:entities", ->
    API.getHeaders()
