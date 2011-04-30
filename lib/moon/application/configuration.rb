require 'configure'

class Moon::Application::Configuration

  SCHEMA = Configure::Schema.build {
    only :route
    nested {
      route {
        only :http_method, :path, :actions
      }
    }
  }.freeze

  def initialize(&block)
    @hash = Configure.process SCHEMA, &block
  end

  def routes
    [ @hash[:route] ].compact.flatten
  end

end
