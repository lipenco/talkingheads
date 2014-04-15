require 'elasticsearch/model'

class Talk < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :conference
  belongs_to :user
  has_many :favourites

  def favorites
    self.favourites.count
  end



end
