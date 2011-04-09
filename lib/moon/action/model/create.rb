
# Generic model create action. Stores the initialized model to the configured storage.
class Moon::Action::Model::Create

  def initialize(context)
    @context = context
  end

  def perform
    model = self.model
    if model
      GOM::Storage.store model, @context.storage_name
      Moon::Response::JSON::Model.new self.class.model_symbol, model
    else
      Moon::Response::JSON::Message.new 200, "No model initialized."
    end
  end

  def model
    @context.models[self.class.model_symbol]
  end

  def self.model_symbol
    Moon::Utility::String.underscore(model_class.to_s).split("/").last.to_sym
  end

  def self.model_class=(value)
    @model_class = value
  end

  def self.model_class
    @model_class
  end

  def self.perform(context)
    new(context).perform
  end

  def self.[](model_class)
    klass = self.dup
    klass.model_class = model_class
    klass
  end

end
