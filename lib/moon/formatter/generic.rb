
# Outputs a hash with all instance variables of the given model.
class Moon::Formatter::Generic

  def hash(model)
    @model = model
    initialize_hash
    inject_instance_variables
    inject_id
    @hash
  end

  private

  def initialize_hash
    @hash = { }
  end

  def inject_instance_variables
    @model.instance_variables.each do |variable_name|
      key = variable_name.to_s.sub(/^@/, "").to_sym
      value = @model.instance_variable_get variable_name
      value.is_a?(GOM::Object::Proxy) ?
        put_reference(key, value) :
        put_regular(key, value)
    end
  end

  def put_regular(key, value)
    @hash[key] = value
  end

  def put_reference(key, reference)
    @hash[:"#{key}_id"] = reference.id
  end

  def inject_id
    id = GOM::Object.id @model
    @hash[:id] = id if id
  end

end
