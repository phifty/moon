
# The action checks if every model in the context is valid.
class Moon::Action::ValidModelsRequired

  def perform(context)
    @context = context
    validation_errors = validate_models
    validation_errors.empty? ? nil : Moon::Response::JSON::ValidationErrors.new(validation_errors)
  end

  private

  def validate_models
    validation_errors = { }
    @context.models.each do |key, model|
      messages = validate_model key, model
      validation_errors[key] = messages unless messages.empty?
    end
    validation_errors
  end

  def validate_model(key, model)
    checks = @context.application.configuration.validators[model.class]
    validator = Moon::Validator.new @context, checks
    validator.messages model
  end

end
