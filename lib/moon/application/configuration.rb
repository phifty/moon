require 'configure'

# Application configuration.
class Moon::Application::Configuration

  SCHEMA = Configure::Schema.build {
    only :route, :validator
    nested {
      route {
        only :http_method, :path, :actions
        argument_keys :http_method, :path
      }
      validator {
        only :model_class, :attributes
      }
    }
  }.freeze

  def initialize(&block)
    @hash = Configure.process SCHEMA, &block
  end

  def routes
    [ @hash[:route] ].compact.flatten
  end

  def validators
    validators = { }
    [ @hash[:validator] ].compact.flatten.each do |validator_hash|
      model_class, attributes = validator_hash.values_at :model_class, :attributes
      validators[model_class] = attributes
    end
    validators
  end

end
