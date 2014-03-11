@Demo.module "TalkApp.List", (List, App, Backbone, Marionette, $, _) ->

	class List.Layout extends App.Views.Layout
		template: "talk/list/list_layout"

		regions:
			panelRegion: "#panel-region"
			talksRegion: "#talk-region"

	class List.Panel extends App.Views.ItemView
		template: "talk/list/_panel"

	class List.Talk extends App.Views.ItemView
		template: "talk/list/_talk"
		tagName: "li"

	class List.Empty extends App.Views.ItemView
		template: "talk/list/_empty"
		tagName: "li"

	class List.Talks extends App.Views.CompositeView
		template: "talk/list/templates/_talks"
		itemView: List.Talk
		emptyView: List.Empty
		itemViewContainer: "ul"
