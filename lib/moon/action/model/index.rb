
# Common model index action
class Moon::Action::Model::Index

  def initialize(collection_key)
    @collection_key = collection_key
  end

  def perform(context)
    Moon::Response::JSON::Collection.new context.collections[@collection_key]
  end

end
