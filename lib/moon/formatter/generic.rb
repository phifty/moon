
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
      @hash[key] = @model.instance_variable_get variable_name
    end
  end

  def inject_id
    @hash[:id] = GOM::Object.id @model
  end

end
