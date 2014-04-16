class TalksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :require_login, only: [:destroy, :create, :update, :new]
  before_action :current_user, only: [:destroy, :create, :update, :new]
  impressionist actions: [:show], unique: [:session_hash]
  respond_to :json


  def show
    @talk = Talk.find params[:id]
  end



  def search
    @talks = Talk.search(params[:q]).records
    render "talks/index"
  end

  def index
    @conference = Conference.find params[:conference_id]
    @talks = @conference.talks
  end


  def new
    @talk = Talk.new(talk_params)
  end

  def create
    @talk = Talk.new(talk_params.merge(:conference_id => params[:conference_id]))

    if @talk.save
      render "talks/show"
    else
      respond_with @single
    end
  end

  def update
    @talk = Talk.find params[:id]
    if @talk.update_attributes talk_params
      @single = Conference.find(params[:conference_id])
      render "conferences/show"
    else
      respond_with @single
    end
  end


  def destroy
    talk = Talk.find params[:id]
    talk.destroy
    render json: {}
  end

  private


  def talk_params
    params.require(:talk).permit(:title, :video_url, :description, :slides_url, :speaker, :conference_id)
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      render json: {} # halts request cycle
    end
  end

end
