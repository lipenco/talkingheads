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
    @talk = Talk.new(talk_params.merge(:conference_id => params[:conference_id]))
    # binding.pry
    if @talk.save
      @single = Conference.find(params[:conference_id])
      # @single.talks << @talk
      render "conferences/show"
    else
      respond_with @single
    end
  end

  def update
    @talk = Talk.find_or_create_by(id: params[:id])
    binding.pry
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





end
