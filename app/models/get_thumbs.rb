class GetThumbs

  THUMBS = {
    marionette: :"http://kroltech.com/wp-content/uploads/2013/08/marionette1.jpg",
    backbone: :"https://scontent-b-iad.xx.fbcdn.net/hphotos-prn1/t1/5543_446948895373302_1141770560_n.jpg",
    ruby:  :"http://www.calstatela.edu/sites/default/files/centers/hipic/classes/images/Ruby-logo-2008.png",
    rails: :"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQUyE5VORKuBi2pcTVcU0XPDwK5uIDlau5Ajz6vXd_rzICeHMcs",
    javascript: :"/assets/js.jpg"
  }

  def self.get(tags)
    THUMBS.keys.each do |tag|
      return THUMBS[tag].to_s if tags.downcase.include?(tag.to_s)
    end
    return
  end

end
