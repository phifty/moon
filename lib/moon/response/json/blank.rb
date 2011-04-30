
# Moon::Response::JSON::Blank provides a simple response with an empty hash
class Moon::Response::JSON::Blank < Moon::Response::JSON

  def initialize
    super 200, { }
  end

end
