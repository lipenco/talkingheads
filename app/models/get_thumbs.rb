class GetThumbs

  THUMBS = {
    marionette: "http://kroltech.com/wp-content/uploads/2013/08/marionette1.jpg",
    backbone: "https://scontent-b-iad.xx.fbcdn.net/hphotos-prn1/t1/5543_446948895373302_1141770560_n.jpg",
    design: "/assets/design2.jpg",
    rails: "/assets/rails.jpg",
    ruby:  "http://www.calstatela.edu/sites/default/files/centers/hipic/classes/images/Ruby-logo-2008.png",
    javascript: "/assets/js.jpg",
    default: "http://blogs.microsoft.co.il/blogs/gilf/CSS3Logo_thumb_57496FDA.jpg"
  }

  def self.get(tags)
    THUMBS.keys.each do |tag|
      return THUMBS[tag] if tags.downcase.include?(tag.to_s)
    end
    THUMBS[:default]
  end

end
