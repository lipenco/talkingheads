class Conference < ActiveRecord::Base
  validates :name, presence: true
  has_many :talks

  accepts_nested_attributes_for :talks, :allow_destroy => true

  def color
    ColorPicker.pick(self.tags) if tags?
  end

  def thumb
    GetThumbs.get(self.tags) if tags?
  end

end
