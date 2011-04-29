
ENV["RACK_ENV"] = "test"

require File.join(File.dirname(__FILE__), "..", "..", "lib", "moon")

require 'rspec/expectations'
require 'rack/test'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rack
end

class TestWorld
  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  Webrat::Methods.delegate_to_session :response_code, :response_body

  def application
    @application ||= Moon::Application.new
  end

  def app
    application.rack
  end

end

World { TestWorld.new }
