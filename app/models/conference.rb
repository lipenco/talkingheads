class Conference < ActiveRecord::Base
  validates :name, presence: true
  has_many :talks

  def color
    ColorPicker.pick(self.tags) if tags?
  end

  def thumb
    GetThumbs.get(self.tags) if tags?
  end

end
