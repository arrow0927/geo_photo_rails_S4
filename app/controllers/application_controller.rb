class ApplicationController < ActionController::API
  include ActionController::MimeResponds # Added by Ash http://railscasts.com/episodes/348-the-rails-api-gem?autoplay=true
  include ActionController::ImplicitRender #Required to allow controller actions to implicitely render templates

  #http://calm-temple-6052.herokuapp.com
end
