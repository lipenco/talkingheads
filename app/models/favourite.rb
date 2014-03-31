class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk

  validates_uniqueness_of :talk_id

  # def self.add_favorite(user, talk)
  #   #todo
  # end

  def favourite_for(user, id)
     return false unless user
  end

end
