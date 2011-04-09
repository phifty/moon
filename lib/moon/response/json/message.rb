
# Moon::Response::JSON::Message provides a simple response with one message
class Moon::Response::JSON::Message < Moon::Response::JSON

  attr_accessor :message
  attr_accessor :id

  def initialize(status, message, id = nil)
    @message, @id = message, id
    super status
  end

  def hash
    id = self.id
    { :message => message }.merge(id ? { :id => id } : { })
  end

end
