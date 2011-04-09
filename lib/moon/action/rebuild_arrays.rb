
# Converts each hash with numeric keys { "0" => "one", "1" => "two" } into arrays [ "one", "two" ].
class Moon::Action::RebuildArrays

  def initialize(context)
    @context = context
  end

  def perform
    @context.parameters = self.class.rebuild_arrays @context.parameters
    nil
  end

  private

  def self.rebuild_arrays(parameters)
    parameters.each do |key, value|
      parameters[key] = rebuild_arrays value if value.is_a?(Hash)
    end

    if array_hash?(parameters)
      array = [ ]
      parameters.keys.map(&:to_i).sort.each do |index|
        array << parameters[index.to_s]
      end
      array
    else
      parameters
    end
  end

  def self.array_hash?(hash)
    hash.size == hash.keys.select{ |key| key.to_s =~ /^\d+$/ }.size
  end

  def self.perform(context)
    new(context).perform
  end

end
