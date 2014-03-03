class Conference < ActiveRecord::Base

  def color
    ColorPicker.pick(self.tags)
  end

  def thumb
    GetThumbs.get(self.tags)   
  end

end
