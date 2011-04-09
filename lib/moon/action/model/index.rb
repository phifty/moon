
# Common model index action
class Moon::Action::Model::Index

  def initialize(context)
    @context = context
  end

  def perform
    Moon::Response::JSON::Collection.new @context.collections[self.class.collection_key]
  end

  def self.collection_key=(value)
    @collection_key = value
  end

  def self.collection_key
    @collection_key
  end

  def self.perform(context)
    new(context).perform
  end

  def self.[](collection_key)
    klass = self.dup
    klass.collection_key = collection_key
    klass
  end

end
