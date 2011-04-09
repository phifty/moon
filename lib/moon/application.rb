
# Main application class.
class Moon::Application

  autoload :Rack, File.join(File.dirname(__FILE__), "application", "rack")
  autoload :Routes, File.join(File.dirname(__FILE__), "application", "routes")

  # This error is raised if an action doesn't respond to :perform.
  class InvalidActionError < StandardError; end

  # This error is raised if a response doesn't respond to :status, :headers and :body.
  class InvalidResponseError < StandardError; end

  attr_reader :routes
  attr_reader :rack

  def initialize
    @routes = Routes.new
  end

  def rack
    @routes.rack.transponder
  end

  def environment
    @rack.environment
  end

  def self.storage_name(environment)
    environment == :test ? :dump : :main
  end

end
