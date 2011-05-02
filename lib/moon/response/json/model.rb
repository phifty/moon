
# Moon::Response::JSON::Collection provides a response that contains one single collection.
class Moon::Response::JSON::Model < Moon::Response::JSON

  def initialize(key, object, formatters)
    @key, @object, @formatters = key, object, formatters
    super 200, hash
  end

  private

  def hash
    { @key.to_s => Moon::Formatter.hash_for(@formatters, @object) }
  end

end
