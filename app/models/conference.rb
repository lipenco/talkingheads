class Conference < ActiveRecord::Base
   validates :name, :tags, presence: true

  def color
    ColorPicker.pick(self.tags)
  end

  def thumb
    GetThumbs.get(self.tags)   
  end

end
