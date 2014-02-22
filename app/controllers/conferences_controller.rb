class ConferencesController < ApplicationController

  def index
  end

  def new
     @conference = Conference.new
  end

  def create
    @conference = Conference.new(conference_params)
    if @conference.save
      flash[:notice] = "Conference has been created."
      redirect_to @conference
    else
      # nothing, yet
     end 
  end

  def show
    @conference = Conference.find(params[:id])
  end

  private

  def conference_params
    params.require(:conference).permit(:name, :description, :date, :place, :organizer, :tags)
  end

end
