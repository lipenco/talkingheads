class CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :require_login, only: [:destroy, :create, :update, :new]
  before_action :current_user, only: [:destroy, :create, :update, :new]
  respond_to :json

  def index
    @talk = Talk.find params[:talk_id]
    @comments = @talk.comments
  end

  def create
    @comment = Comment.new(coment_params.merge(:talk_id => params[:talk_id]))
    @comment.user_id = current_user.id
    if @comment.save
      render "comments/show"
    else
      respond_with @single
    end
  end

  private

  def coment_params
    params.require(:comment).permit(:content, :user_id, :talk_id)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      render json: {} # halts request cycle
    end
  end

end
