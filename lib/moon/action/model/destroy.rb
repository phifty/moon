
# Generic model destroy action. Removes the specified model from the storage.
class Moon::Action::Model::Destroy

  def initialize(model_symbol)
    @model_symbol = model_symbol
  end

  def perform(context)
    model = context.models[@model_symbol]
    model_class = model.class
    if model
      GOM::Storage.remove model
      Moon::Response::JSON::Message.new 200, "#{model_class} destroyed."
    else
      Moon::Response::JSON::Message.new 401, "#{model_class} destruction failed."
    end
  end

end
