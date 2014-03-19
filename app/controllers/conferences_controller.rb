class ConferencesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    @conferences = Conference.all
  end

  def new
     @single = Conference.new(conference_params)
     @new_talk = @single.talks.build
  end

  def create
    @single = Conference.new(conference_params)
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
    single = Conference.find params[:id]
    single.destroy
    render json: {}
  end

  private

  def conference_params
    params.permit(:name, :tags, :date, :organizer, :description, :place)
  end

end
