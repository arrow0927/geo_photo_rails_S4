# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  lat                :string(255)
#  lng                :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  
   COORDINATE_DELTA = 0.05
   
  attr_accessible :lat, :lng, :image

  #This method sets the folder structure that Paperclip will use to save the files on AWS
   #The first bit sets the folder name to the user email and the second bit sets the name of the
   #internal folder to the datetime the file was created
  #Paperclip.interpolates :prefix  do |attachment, style|
   #  "Leah_Huyghe/#{Date.today.to_s }"

  #end
  
  
  has_attached_file :image,
                    #:path => ":prefix/:basename.:extension",
                    :styles => { :thumbnail => "57x57#" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS
  
  
   validates :image,:presence => true
   validates :lat, :lng,:presence => true,:numericality => true
   
   scope :nearby, lambda { |lat, lng|
     where("lat BETWEEN ? AND ?", lat - COORDINATE_DELTA, lat + COORDINATE_DELTA).
     where("lng BETWEEN ? AND ?", lng - COORDINATE_DELTA, lng + COORDINATE_DELTA).
     limit(64)
   }
   def as_json(options = nil)
     {
       :lat => self.lat,
       :lng => self.lng,

       :image_urls => {
         :original => self.image.url,
         :thumbnail => self.image.url(:thumbnail)
       },

       :created_at => self.created_at.iso8601
     }
     
     #Generates this
=begin
     def as_json(options = nil)
       {
         :lat => self.lat,
         :lng => self.lng,

         :image_urls => {
           :original => self.image.url,
           :thumbnail => self.image.url(:thumbnail)
         },

         :created_at => self.created_at.iso8601
       }
     end
   
=end   
  end
end
