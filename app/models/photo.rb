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
#  description        :string(255)
#  takenby            :string(255)
#

class Photo < ActiveRecord::Base
  
   COORDINATE_DELTA = 0.05
  attr_accessible :lat, :lng, :image
  
  Paperclip.interpolates :prefix  do |attachment, style|
     "#{attachment.instance.takenby}/#{Date.today.to_s }/#{attachment.instance.image_file_name}"
  end 
  
  has_attached_file :image,
                    :path => ":prefix/:style/:basename.:extension",
                    :styles => { :thumbnail => "75x75", :original => "300x300" },
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
