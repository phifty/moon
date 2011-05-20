
# Common model index action
class Moon::Action::Model::Index

  def initialize(collection_key)
    @collection_key = collection_key
  end

  def perform(context)
    @context = context
    Moon::Response::JSON::Collection.new collection, formatters
  end

  private

  def collection
    @context.collections[@collection_key]
  end

  def formatters
    @context.application.configuration.formatters
  end

end
