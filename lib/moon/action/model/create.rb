
# Generic model create action. Stores the initialized model to the configured storage.
class Moon::Action::Model::Create

  def initialize(model_class)
    @model_class = model_class
    @model_symbol = Moon::Utility::String.underscore(@model_class.to_s).split("/").last.to_sym
  end

  def perform(context)
    model = context.models[@model_symbol]
    if model
      application = context.application
      GOM::Storage.store model, application.storage_name
      Moon::Response::JSON::Model.new @model_symbol, model, application.configuration.formatters
    else
      Moon::Response::JSON::Message.new 200, "No model initialized."
    end
  end

end
