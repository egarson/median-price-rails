#
# Base controller class
#
class ApplicationController < ActionController::Base
  respond_to :json # this app is only a service
  protect_from_forgery
end
