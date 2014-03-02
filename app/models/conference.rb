class Conference < ActiveRecord::Base



  def color
    if tags?
      return "purple" if self.tags.downcase.include?("marionette")
      return "yellow" if self.tags.downcase.include?("backbone")
      return "green " if self.tags.downcase.include?("ruby")
      return "red " 
    end
  end

  def thumb
    if tags?
      return "http://kroltech.com/wp-content/uploads/2013/08/marionette1.jpg" if self.tags.downcase.include?("marionette")
      return "https://scontent-b-iad.xx.fbcdn.net/hphotos-prn1/t1/5543_446948895373302_1141770560_n.jpg" if self.tags.downcase.include?("backbone")
      return "http://www.calstatela.edu/sites/default/files/centers/hipic/classes/images/Ruby-logo-2008.png" if self.tags.downcase.include?("ruby")
      return "red" 
    end
  end


end
