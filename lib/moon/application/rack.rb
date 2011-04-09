require 'sinatra/base'

# Adapter for Rack-up servers. Sinatra is used as helper.
class Moon::Application::Rack

  attr_reader :routes
  attr_reader :transponder
  attr_reader :environment

  def initialize
    initialize_transponder
  end

  def routes=(routes)
    @routes = routes
    map_routes
  end

  def call(*arguments)
    @transponder.call *arguments
  end

  private

  def initialize_transponder
    @transponder = Class.new Sinatra::Base
    @transponder.enable :sessions
    @transponder.disable :show_exceptions
    @transponder.set :public, "public"
    @transponder.error do
      error = request.env["sinatra.error"]
      error.message + "\n" + error.backtrace.join("\n")
    end
    @environment = @transponder.environment
  end

  def map_routes
    @routes.each do |route|
      Route.new(@transponder, route).define
    end
  end

  # Abstraction for a application route
  class Route

    attr_reader :response
    attr_reader :rack_response

    def initialize(transponder, route)
      @transponder = transponder
      @environment = @transponder.environment
      @route = route
    end

    def http_method
      @route[:http_method]
    end

    def path
      @route[:path]
    end

    def actions
      @route[:actions] || [ ]
    end

    def define
      route = self
      @transponder.send http_method, path do
        route.handle session, params
      end
    end

    def handle(session, params)
      build_context session, params
      perform_actions
      build_rack_response
      @rack_response
    end

    private

    def build_context(session, params)
      @context = Moon::Context.new session, params
      @context.storage_name = Moon::Application.storage_name @environment
    end

    def perform_actions
      actions.each do |action|
        raise Moon::Application::InvalidActionError, "Actions must implement a :perform method!" unless action.respond_to?(:perform)
        @response = action.perform @context
        return if @response
      end
    end

    def build_rack_response
      raise Moon::Application::InvalidResponseError, "Responses must implement the :status, :headers and :body methods" unless
        @response.respond_to?(:status) && @response.respond_to?(:headers) && @response.respond_to?(:body)
      @rack_response = [ @response.status, @response.headers, @response.body ]
    end

  end

end
