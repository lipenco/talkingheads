class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk


  def author_name
    User.find(self.user_id).name
  end

  def author_image
    User.find(self.user_id).image
  end
end
