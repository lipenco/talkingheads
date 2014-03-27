class FavouritesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :require_login
  before_action :set_current_user
  respond_to :json

  def list
    @favourites = Talk.where(:id => @current_user.favourites.pluck(:talk_id))
  end

  private

  def set_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      render json: {} # halts request cycle
    end
  end

end
