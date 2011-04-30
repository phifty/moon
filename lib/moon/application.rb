
# Main application class.
class Moon::Application

  autoload :Configuration, File.join(File.dirname(__FILE__), "application", "configuration")
  autoload :Rack, File.join(File.dirname(__FILE__), "application", "rack")

  # This error is raised if an action doesn't respond to :perform.
  class InvalidActionError < StandardError; end

  # This error is raised if a response doesn't respond to :status, :headers and :body.
  class InvalidResponseError < StandardError; end

  def initialize
    @rack = Rack.new
  end

  def configure(&block)
    configuration = Configuration.new &block
    @rack.routes = configuration.routes
  end

  def rack
    @rack.transponder
  end

  def environment
    @rack.environment
  end

  def self.storage_name(environment)
    environment == :test ? :dump : :main
  end

end
