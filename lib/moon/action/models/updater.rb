
# Uses the parameters in the context and tries to update the models.
class Moon::Action::Models::Updater

  def initialize(context)
    @context = context
  end

  def perform
    @context.models.each do |model_key, model|
      Model.new(model, @context.parameters[model_key]).update
    end
    nil
  end

  # Model updater.
  class Model

    def initialize(model, parameters = { })
      @model, @parameters = model, parameters
    end

    def update
      @parameters.each do |key, value|
        method_name = "#{key}=".to_sym
        @model.send method_name, value if @model.respond_to?(method_name)
      end
    end

  end

  def self.perform(context)
    new(context).perform
  end

end
