class TalksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    @talks = Conference.all
  end



end