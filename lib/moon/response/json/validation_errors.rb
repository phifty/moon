
# Moon::Response::JSON::ValidationErrors provides a simple response with the validation messages
class Moon::Response::JSON::ValidationErrors < Moon::Response::JSON

  def initialize(validation_errors)
    super 200, :validation_errors => validation_errors
  end

end
