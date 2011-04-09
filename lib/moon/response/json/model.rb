
# Moon::Response::JSON::Collection provides a response that contains one single collection.
class Moon::Response::JSON::Model < Moon::Response::JSON

  def initialize(key, object)
    @key, @object = key, object
    super 200, hash
  end

  private

  def hash
    { @key.to_s => Moon::Formatter.hash_for(@object) }
  end

end
