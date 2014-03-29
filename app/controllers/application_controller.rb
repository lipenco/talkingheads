class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
		gon.rabl
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
		# @user = User.first ##just an example of an authenticated user
		gon.rabl "app/views/users/show.json.rabl"
	end




  private

  def logged_in?
    !session[:user_id].nil?
  end
  helper_method :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @favorites = @current_user.favourites.pluck(:talk_id)
  end
  helper_method :current_user






end
