if @photo.save
 object @photo
 attributes :id
else
 object @photo
 attributes :errors
end