
# Common model show action
class Moon::Action::Model::Show

  def initialize(context)
    @context = context
  end

  def perform
    model_key = self.class.model_key
    Moon::Response::JSON::Model.new model_key, @context.models[model_key]
  end

  def self.model_key=(value)
    @model_key = value
  end

  def self.model_key
    @model_key
  end

  def self.perform(context)
    new(context).perform
  end

  def self.[](model_key)
    klass = self.dup
    klass.model_key = model_key
    klass
  end

end
