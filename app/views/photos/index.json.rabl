collection @photos => :photos 
attributes :lat, :lng, :takenby, :description, :image_file_name

node(:image_urls)  { |p| { :original => p.image.url, :thumbnail  => p.image.url(:thumbnail)} }


 


