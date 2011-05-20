
# Updates or creates the given model.
class Moon::Action::Model::UpdateOrCreate

  def initialize(model_class)
    @model_class = model_class
    @model_symbol = Moon::Utility::String.underscore(@model_class.to_s).split("/").last.to_sym
  end

  def perform(context)
    @context = context
    @context.models.has_key?(@model_symbol) ?
      Moon::Action::Model::Update.new(@model_symbol).perform(@context) :
      Moon::Action::Model::Create.new(@model_class).perform(@context)
  end

end
