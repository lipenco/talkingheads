require 'elasticsearch/model'

class Talk < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  is_impressionable

  belongs_to :conference
  belongs_to :user
  has_many :favourites

  def favorites
    self.favourites.count
  end

  def views_count
    self.impressionist_count(:filter=>:session_hash)
  end



end
