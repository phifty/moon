
# Common model show action
class Moon::Action::Model::Show

  def initialize(model_key)
    @model_key = model_key
  end

  def perform(context)
    Moon::Response::JSON::Model.new @model_key, context.models[@model_key], context.application.configuration.formatters
  end

end
