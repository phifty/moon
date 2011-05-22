
# Common model show action
class Moon::Action::Model::Show

  def initialize(model_key)
    @model_key = model_key
  end

  def perform(context)
    model = context.models[@model_key]
    if model
      Moon::Response::JSON::Model.new @model_key, context.models[@model_key], context.application.configuration.formatters
    else
      Moon::Response::JSON::Message.new 404, "Model not found."
    end
  end

end
