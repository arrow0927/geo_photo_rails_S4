# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  lat                :decimal(15, 10)
#  lng                :decimal(15, 10)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  attr_accessible :lat, :lng
  
  has_attached_file :image,
                    :styles => { :thumbnail => "100x100#" },
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS
  
  
end
