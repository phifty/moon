
# Moon::Response::JSON::Collection provides a response that contains one single collection.
class Moon::Response::JSON::Collection < Moon::Response::JSON

  def initialize(collection, formatters)
    @collection = collection.map do |object|
      Moon::Formatter.hash_for formatters, object
    end
    super 200, @collection
  end

end
