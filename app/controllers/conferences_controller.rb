class ConferencesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :require_login, only: [:destroy, :create, :update, :new]
  before_action :current_user, only: [ :destroy, :create, :update, :new, :user_list]
  respond_to :json

  def index
    @conferences = Conference.where(:public=> true).order('created_at DESC')
  end

  def praginate
    @conferences = Conference.where(:public=> true).page(params[:page]).order('id DESC')
    render "conferences/index"
  end

  def user_list
    @user_list = @current_user.conferences.all
  end


  def new
     @single = Conference.new(conference_params)
     @new_talk = @single.talks.build
  end

  def create
    @single = @current_user.conferences.new(conference_params)
    if @single.save
      render "conferences/show"
    else
      respond_with @single
    end
  end

  def update
    @single = Conference.find params[:id]
    if @single.update_attributes conference_params
      render "conferences/show"
    else
      respond_with @single
    end
  end

  def show
    @single = Conference.find(params[:id])
  end

  def destroy
    single = @current_user.conferences.find params[:id]

    single.destroy
    render json: {}
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      render json: {} # halts request cycle
    end
  end

  def conference_params
    params.permit(:name, :tags, :date, :organizer, :description, :place, :public, :talks_attributes => [:title, :video_url])
  end

end
