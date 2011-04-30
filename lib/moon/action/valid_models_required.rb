
# The action checks if every model in the context is valid.
class Moon::Action::ValidModelsRequired

  def self.perform(context)
    validation_errors = validate_models context
    validation_errors.empty? ? nil : Moon::Response::JSON::ValidationErrors.new(validation_errors)
  end

  private

  def self.validate_models(context)
    validation_errors = { }
    context.models.each do |key, model|
      messages = validate_model context, key, model
      validation_errors[key] = messages unless messages.empty?
    end
    validation_errors
  end

  def self.validate_model(context, key, model)
    checks = context.application.configuration.validators[model.class]
    validator = Moon::Validator.new checks
    validator.messages model
  end

end
