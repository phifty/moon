
# This action takes parameter and session keys that ends with '_id' out of the context and searches the fitting model
# for it. The result is assign to the context models.
class Moon::Action::Models::Finder

  def perform(context)
    @context = context
    find_session_models
    find_parameter_models
    nil
  end

  private

  def find_session_models
    @context.session.each do |key, value|
      find_model key, value, "current_" if self.class.point_to_model?(key)
    end
  end

  def find_parameter_models
    @context.parameters.each do |key, value|
      find_model key, value if self.class.point_to_model?(key)
    end
  end

  def find_model(key, id, prefix = "")
    model_name = self.class.model_name key
    model = GOM::Storage.fetch id
    @context.models[:"#{prefix}#{model_name.downcase}"] = model
  end

  private

  def self.point_to_model?(key)
    key.to_s =~ /_id$/
  end

  def self.model_name(key)
    key.to_s.sub(/_id$/, "").capitalize
  end

end
