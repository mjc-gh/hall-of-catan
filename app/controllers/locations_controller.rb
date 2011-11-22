class LocationsController < ApplicationController
  before_filter :find_location, :except =>  [:index, :new, :create]
  
  def index
    @locations = Location.all
    respond_with @locations
  end

  def show
    respond_with @location
  end

  def new
    @location = Location.new
    respond_with @location
  end
  
  def create
    @location = Location.create(params[:location])
    respond_with @location
  end

  def edit
    respond_with @location
  end
  
  def update
    @location.update_attributes(params[:location])
    respond_with @location
  end
  
  # TODO deal with data-deps
  # def destroy
  #   @location.destroy
  #   respond_with @location
  # end

  protected
  
  def find_location
    @location = Location.find(params[:id])
  end
end
