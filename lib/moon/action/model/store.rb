
# Generic model update action. Stores the specified model to the storage.
class Moon::Action::Model::Store

  def initialize(model_symbol)
    @model_symbol = model_symbol
  end

  def perform(context)
    model = context.models[@model_symbol]
    if model
      storage_name = GOM::Object.storage_name(model) || context.application.storage_name
      GOM::Storage.store model, storage_name
      nil
    else
      Moon::Response::JSON::Message.new 200, "No model initialized."
    end
  end

end
