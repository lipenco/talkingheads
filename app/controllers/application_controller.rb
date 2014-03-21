class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user


  # private
  #
  # def set_user
  #   @request = request
  #   set_current_user
  #   # check_login_cookie unless @current_user
  # end
  #
  # def set_current_user
  #   @current_user = nil && return unless session[:user_id]
  #   @current_user = User.where(:id => session[:user_id].to_i).first
  # end

  # def check_login_cookie
  #   user, token = LoginToken.get_user_for(request, response)
  #   if user
  #     session[:user_id] = user.id
  #     session[:token_id] = token.id
  #     @current_user = user
  #   end
  # end


end
