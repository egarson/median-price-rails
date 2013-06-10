ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require Rails.root.join('app/common.rb')

RSpec.configure do |config|
  # config.mock_with :mocha
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

def check_headers(resp)
  unless resp.nil? || resp.status == NO_CONTENT_204
	['application/json','charset=utf-8'].each { |s| resp.headers['Content-Type'].should match s }
	resp.headers['ETag'].should_not be_nil unless resp.status == BAD_REQUEST_400
  end
end
