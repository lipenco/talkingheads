class Talk < ActiveRecord::Base
  belongs_to :conference
  belongs_to :user
  has_many :favourites

  def favorites
    self.favourites.count
  end



end
