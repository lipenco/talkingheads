class User < ActiveRecord::Base
  has_many :conferences
  has_many :talks, through: :conferences
  has_many :favourites

  # def self.initialize_with_auth(auth)
  #   user = User.find_or_initialize_by_uid_and_provider(auth[:uid], auth[:provider])
  #   user.name ||= auth[:info][:name] || auth[:info][:nickname]
  #   user.provider ||= auth[:provider]
  #   user.email ||= auth[:info][:email] if auth[:info][:email]
  #   user
  # end



  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email ||= auth[:info][:email] if auth[:info][:email]
    end
  end

end
