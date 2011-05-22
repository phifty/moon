
# The action transfers a value from the given store object and stores it in the given model attribute.
class Moon::Action::Transfer

  def initialize(options)
    from, to = options.values_at :from, :to
    @store_method, @store_key = from
    @model_key, @model_attribute = to
  end

  def perform(context)
    @context = context
    fetch_value
    store_value
    nil
  end

  private

  def fetch_value
    store = @context.send @store_method.to_sym
    @value = store[@store_key.to_sym]
  end

  def store_value
    model = @context.models[@model_key.to_sym]
    model.send :"#{@model_attribute}=", @value
  end

end
