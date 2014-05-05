@Demo.module "TalkApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "talk/show/show_layout"

    regions:
      titleRegion:   "#title-region"
      videoRegion:   "#video-region"
      talksRegion:   "#talks-region"
      starRegion:    "#star-region"
      speakerRegion:  "#speaker-region"
      commentsRegion: "#comments-region"
      descriptionRegion: "#description-region"
      shareRegion:  "#share-region"


  class Show.Title extends App.Views.ItemView
    template: "talk/show/_title"

  class Show.Speaker extends App.Views.ItemView
    template: "talk/show/_speaker"

  class Show.Share extends App.Views.ItemView
    template: "talk/show/_share"

    events:
      "click .social-toggle" : "toggle"
      "click .share": "share"

    toggle: (e) =>
      @$el.find(".social-networks").toggleClass('open-menu')

    share: (e) =>
      e.preventDefault();
      url = $(e.currentTarget).attr('href')
      @openPopup(url, 600, 300)


    openPopup: (url, width, height) ->
      console.log(url);
      left = (window.screen.width / 2) - ((width / 2) + 10);
      top = (window.screen.height / 2) - ((height / 2) + 50);
      window.open(url, "ShareTalkWindow", "status=no,height=" + height + ",width=" + width + ",resizable=yes,left=" + left + ",top=" + top + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no")


  class Show.Description extends App.Views.ItemView
    template: "talk/show/_description"
    className: "description-cont"


  class Show.Video extends App.Views.ItemView
    template: "talk/show/_video"


  class Show.Talk extends App.Views.ItemView
    template: "talk/show/_talk"
    tagName: "li"

    triggers:
      "click"      : "talk:single:render"


  class Show.Talks extends App.Views.CompositeView
    template: "talk/show/_talks"
    itemView: Show.Talk
    itemViewContainer: "ul"

    onShow: ->
      elll = @.model.id
      # @childElementsFadeIn()
      @$el.find("##{elll}").parent().addClass("highlight")
