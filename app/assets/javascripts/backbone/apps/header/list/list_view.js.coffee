@Demo.module "HeaderApp.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Header extends App.Views.ItemView
		template: "header/list/_header"
		tagName: "li"

	class List.Headers extends App.Views.CompositeView
		template: "header/list/headers"
		itemView: List.Header
		itemViewContainer: "ul"

		onShow:->
			@scrollHeader()

		scrollHeader: ->
			$(window).scroll ->
			  if $(document).scrollTop() is 0
			    # $("#header").removeClass "tiny"
			  else
			    $("#header").addClass "tiny"
			  return
