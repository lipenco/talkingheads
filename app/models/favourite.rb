class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk

  validates_uniqueness_of :talk_id


  def favourite_for(user, id)
     return false unless user
  end

end
