
# This action takes parameters that ends with '_id' out of the context and searches the fitting model
# for it. The result is assign to the context.
class Moon::Action::Models::Finder

  def initialize(context)
    @context = context
  end

  def perform
    find_models
    nil
  end

  private

  def find_models
    @context.parameters.each do |key, value|
      find_model key, value if self.class.point_to_model?(key)
    end
  end

  def find_model(key, id)
    model_name = self.class.model_name key
    model = GOM::Storage.fetch id
    @context.models[model_name.downcase.to_sym] = model
  end

  def self.perform(context)
    new(context).perform
  end

  private

  def self.point_to_model?(key)
    key.to_s =~ /_id$/
  end

  def self.model_name(key)
    key.to_s.sub(/_id$/, "").capitalize
  end

end
