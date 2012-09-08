class PhotosController < ApplicationController
  #Added by Ash per http://railscasts.com/episodes/348-the-rails-api-gem?autoplay=true
  include ActionController::Helpers
  include ActionController::Cookies #depends on helpers modules
  
  
  #==========================================================================
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all

    #No respond to block is necessary because implicit rendering module included
  end

  #==========================================================================
  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])

    #No respond to block is necessary because implicit rendering module included
  end

  #==========================================================================
  # GET /photos/new
  # GET /photos/new.json
=begin
  def new
    @photo = Photo.new

    render json: @photo
  end
=end
  #==========================================================================
  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(params[:photo])

    #No respond to block is necessary because implicit rendering module included
  end

  #==========================================================================
  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
=begin
  def update
    @photo = Photo.find(params[:id])

    if @photo.update_attributes(params[:photo])
      head :no_content
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end
=end
  #==========================================================================
  # DELETE /photos/1
  # DELETE /photos/1.json
=begin
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    head :no_content
  end
=end
end
