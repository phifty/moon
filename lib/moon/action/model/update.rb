
# Generic model update action. Stores the specified model to the storage.
class Moon::Action::Model::Update

  def initialize(model_symbol)
    @model_symbol = model_symbol
  end

  def perform(context)
    model = context.models[@model_symbol]
    if model
      storage_name = GOM::Object.storage_name model
      GOM::Storage.store model, storage_name
      Moon::Response::JSON::Message.new 200, "#{@model_symbol} updated."
    else
      Moon::Response::JSON::Message.new 401, "#{@model_symbol} update failed."
    end
  end

end
