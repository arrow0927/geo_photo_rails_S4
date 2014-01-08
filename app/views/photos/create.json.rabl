@photo => :photo 
attributes :id, :lat, :lng, :image_file_name

node(:image_urls)  { |p| { :original => p.image.url, :thumbnail  => p.image.url(:thumbnail)} }