
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
      validator = Moon::Validator[model.class].new model
      validation_errors[key] = validator.messages unless validator.ok?
    end
    validation_errors
  end

end
