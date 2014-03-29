class FavouritesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :require_login
  before_action :current_user
  respond_to :json

  def list
    @favourites = Talk.where(:id => @current_user.favourites.pluck(:talk_id))
  end

  def create
    talk = talk.find(params[:id])

    if talk
        return 401 unless @current_user

        favourite = talk.favourite_for(@current_user, params[:id])
        if favourite.save
          render "favourites/list"
        end
      end
  end

  private


  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      render json: {} # halts request cycle
    end
  end

end
