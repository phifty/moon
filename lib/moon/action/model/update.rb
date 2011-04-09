
# Generic model update action. Stores the specified model to the storage.
class Moon::Action::Model::Update

  def initialize(context)
    @context = context
  end

  def perform
    model = self.model
    if model
      storage_name = GOM::Object.storage_name model
      GOM::Storage.store model, storage_name
      Moon::Response::JSON::Message.new 200, "#{@model_symbol} updated."
    else
      Moon::Response::JSON::Message.new 401, "#{@model_symbol} update failed."
    end
  end

  def model
    @context.models[self.class.model_symbol]
  end

  def self.model_symbol=(value)
    @model_symbol = value
  end

  def self.model_symbol
    @model_symbol
  end

  def self.perform(context)
    new(context).perform
  end

  def self.[](model_symbol)
    klass = self.dup
    klass.model_symbol = model_symbol
    klass
  end

end
