class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, I use :null_session instead.
  protect_from_forgery with: :null_session
end
