#
# Base controller class
#
class ApplicationController < ActionController::Base
  # responding to :html is only a (minor) development convenience
  respond_to :html, :json
  protect_from_forgery
end
