
# Moon::Response::JSON::Collection provides a response that contains one single collection.
class Moon::Response::JSON::Collection < Moon::Response::JSON

  def initialize(collection)
    @collection = collection.map do |object|
      Moon::Formatter.hash_for object
    end
    super 200, @collection
  end

end
