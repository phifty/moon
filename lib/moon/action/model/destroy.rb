
# Generic model destroy action. Removes the specified model from the storage.
class Moon::Action::Model::Destroy

  def initialize(context)
    @context = context
  end

  def perform
    model = self.model
    model_class = model.class
    if model
      GOM::Storage.remove model
      Moon::Response::JSON::Message.new 200, "#{model_class} destroyed."
    else
      Moon::Response::JSON::Message.new 401, "#{model_class} destruction failed."
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
