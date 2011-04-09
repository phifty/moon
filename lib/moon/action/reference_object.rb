
# The action creates a reference to the given store object and stores it in the given model attribute.
class Moon::Action::ReferenceObject

  def initialize(options)
    from, to = options.values_at :from, :to
    @store_method, @store_key = from
    @model_key, @model_attribute = to
  end

  def perform(context)
    @context = context
    fetch_object
    create_reference
    store_reference
    nil
  end

  private

  def fetch_object
    store = @context.send @store_method.to_sym
    @object = store[@store_key.to_sym]
  end

  def create_reference
    @reference = GOM::Object.reference @object
  end

  def store_reference
    model = @context.models[@model_key.to_sym]
    model.send :"#{@model_attribute}=", @reference
  end

end
