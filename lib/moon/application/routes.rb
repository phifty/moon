require 'configure'

# Handler for the application routes.
class Moon::Application::Routes

  attr_reader :rack

  def initialize
    @rack = Moon::Application::Rack.new
  end

  def define(&block)
    @rack.routes = [ Configure.process(&block)[:route] ].flatten
  end

end
