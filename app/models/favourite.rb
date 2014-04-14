class Favourite < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk

  def favourite_for(user, id)
     return false unless user
  end

end
