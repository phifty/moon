require 'configure'

# Application configuration.
class Moon::Application::Configuration

  SCHEMA = Configure::Schema.build {
    only :route, :validator, :formatter
    nested {
      route {
        only :http_method, :path, :actions
        argument_keys :http_method, :path
      }
      validator {
        only :model_class, :attributes
      }
      formatter {
        only :model_class, :object
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

  def formatters
    formatters = { }
    [ @hash[:formatter] ].compact.flatten.each do |formatter_hash|
      model_class, object = formatter_hash.values_at :model_class, :object
      formatters[model_class] = object
    end
    formatters
  end

end
