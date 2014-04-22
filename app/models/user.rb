class User < ActiveRecord::Base
  has_many :conferences
  has_many :talks, through: :conferences
  has_many :favourites
  has_many :comments


  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email ||= auth[:info][:email] if auth[:info][:email]
      user.image = auth['info']['image'].sub("_normal", "") if auth['provider'] == 'twitter'
    end
  end

end
