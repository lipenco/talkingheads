class CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :require_login, only: [:destroy, :create, :update, :new]
  before_action :current_user, only: [:destroy, :create, :update, :new]
  respond_to :json

  def index
    @talk = Talk.find params[:talk_id]
    @comments = @talk.comments
  end

end
