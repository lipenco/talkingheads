class TalksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json


  def show
    @talk = Talk.find(params[:id])
  end


  def destroy
    talk = Talk.find params[:id]
    talk.destroy
    render json: {}
  end

  private

  def talk_params
    params.permit(:title, :video_url, :description, :slides_url, :speaker)
  end





end
