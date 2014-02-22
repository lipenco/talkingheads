@Demo.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Header extends Marionette.ItemView
    template: "header/list/templates/list_header"
