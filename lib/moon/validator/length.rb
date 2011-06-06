
# Value length validator.
class Moon::Validator::Length

  def initialize(range)
    @range = range
  end

  def messages(value, context)
    raise ArgumentError, "Value doesn't response to :size" unless value.respond_to?(:size)
    size, minimum, maximum = value.size, @range.min, @range.max
    @range.include?(size) ?
      [ ] :
      [ "Must have at #{size < minimum ? ("least " + minimum.to_s) : ("most " + maximum.to_s)} entries." ]
  end

end
