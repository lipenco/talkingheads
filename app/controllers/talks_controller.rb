class TalksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json


  def show
    @talk = Talk.find params[:id]
  end

  def index
    @talks = Talk.all
  end

  def new
     @talk = Talk.new(talk_params)
  end

  def create
    @talk = Talk.new(talk_params)
    if @talk.save
      render "talk/show"
    else
      respond_with @talk
    end
  end

  def update
    @talk = Talk.find params[:id]
    if @talk.update_attributes talk_params
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
    params.permit(:title, :video_url, :description, :slides_url, :speaker, :conference_id)
  end





end
