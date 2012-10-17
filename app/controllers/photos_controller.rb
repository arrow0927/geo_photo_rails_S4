class PhotosController < ApplicationController
  #Added by Ash per http://railscasts.com/episodes/348-the-rails-api-gem?autoplay=true
  include ActionController::Helpers
  include ActionController::Cookies #depends on helpers modules
  
  
  #==========================================================================
  # GET /photos
  # GET /photos.json
  def index
    lat, lng = params[:lat], params[:lng]
      if lat and lng
        #@photos = Photo.nearby(lat.to_f, lng.to_f)
        @photos = Photo.all
      #else
        #COORDINATE_DELTA = 0.05
        
       
        #@photos = Photo.where("lat BETWEEN ? AND ?", lat - COORDINATE_DELTA, lat + COORDINATE_DELTA).where("lng BETWEEN ? AND ?", lng - COORDINATE_DELTA, lng + COORDINATE_DELTA).limit(64)
        #respond_with({:message => "Invalid or missing lat/lng parameters"}, :status => 406)
      #end

    #@photos = Photo.all
    
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
    @photo.lat = params["photo%5Blat%5D"].to_s
    @photo.lng = params["photo%5Blng%5D"].to_s
    @photo.description = params[:description]
    @photo.takenby = params[:takenby].to_s
    @filename = params[:fname].to_s
    #For some reason when the client sends a photo it cannot be saved 
    #to db because the lat and lng parameters are not saved to the object
    #This causes the DB save method in rails to roll back - see console
    #@photo.lat = 49.2505
    #@photo.lng = -123.1119
    #@photo.image_file_name = "#{Time.zone.now.utc.iso8601}_#{params[:original_filename]}"
    puts "photos_controller/create-@photo.lat = #{@photo.lat}"
    puts "photos_controller/create-@photo.lng = #{@photo.lng}"
    #puts "photos_controller/create-@photo.lng = #{@photo.image_file_name}"
    @photo.save
    
    puts "photos/create photos.inspect= #{@photo.inspect}"

   
    
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
