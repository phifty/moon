
# Context class that contains anything necessary to run a guard, action or response builder.
class Moon::Context

  attr_accessor :storage_name

  def initialize(session = { }, parameters = { })
    @session, @parameters = session, parameters
  end

  [ :session, :parameters, :models, :collections ].each do |key|

    define_method :"#{key}" do
      instance_variable_set :"@#{key}", { } unless instance_variable_defined?(:"@#{key}")
      instance_variable_get :"@#{key}"
    end

    define_method :"#{key}=" do |value|
      raise ArgumentError, "#{key} must be a hash" unless value.is_a?(Hash)
      instance_variable_set :"@#{key}", value
    end

  end

end
