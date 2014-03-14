class TalksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json


  def destroy
    talk = Talk.find params[:id]
    talk.destroy
    render json: {}
  end




end
