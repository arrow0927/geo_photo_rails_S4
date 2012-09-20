collection @photos => :photos 
attributes :lat, :lng

node(:image_urls)  { |p| { :original => p.image.url, :thumbnail  => p.image.url(:thumbnail)} }


 


