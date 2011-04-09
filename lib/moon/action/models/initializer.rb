
# This action searches for hash values in the parameters and tries to initialize
# a model from it.
class Moon::Action::Models::Initializer

  def self.perform(context)
    initialize_models context
    nil
  end

  private

  def self.initialize_models(context)
    context.parameters.each do |key, value|
      context.models[key.to_sym] = Builder.new(key, value).model
    end
  end

  # Build a model out of the key and the hash
  class Builder

    def initialize(key, attributes)
      @key, @attributes = key, attributes
    end

    def model
      fetch_model_class
      initialize_model
      set_model_attributes
      @model
    end

    private

    def fetch_model_class
      @model_class = Object.const_get(Moon::Utility::String.camelize(@key.to_s))
    end

    def initialize_model
      @model = @model_class.new
    end

    def set_model_attributes
      @attributes.each do |key, value|
        @model.send :"#{key}=", value
      end
    end

  end

end
