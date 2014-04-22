require 'elasticsearch/model'

class Talk < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  is_impressionable :counter_cache => true, :unique => :session_hash

  belongs_to :conference
  belongs_to :user
  has_many :favourites
  has_many :comments

  def favorites
    self.favourites.count
  end

  def impressions_count
    self[:impressions_count] || 0
  end





end
