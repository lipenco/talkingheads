class ConferencesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def index
    @conferences = Conference.all
    # color
  end

  def new
     @single = Conference.new(conference_params)
  end

  def create
    @single = Conference.new(conference_params)
    if @single.save
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
    single.destroy()
    render json: {}
  end

  private

  def conference_params
    params.permit(:name, :date, :place, :tags, :description)
  end

end
