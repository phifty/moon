
# Value length validator.
class Moon::Validator::Length
  extend Moon::Utility::Template

  template :minimum, :maximum

  attr_accessor :value

  def initialize(value)
    @value = value
    @ok, @messages = true, [ ]
  end

  def ok?
    check
    @ok
  end

  def message
    check
    @message
  end

  def minimum
    self.class.minimum
  end

  def maximum
    self.class.maximum
  end

  private

  def check
    raise ArgumentError, "Value doesn't response to :size" unless @value.respond_to?(:size)
    size, minimum, maximum = @value.size, self.minimum, self.maximum
    @ok = (!minimum || size >= minimum) && (!maximum || size <= maximum)
    @message = "Must have at #{size < minimum ? ("least " + minimum.to_s) : ("most " + maximum.to_s)} entries." unless @ok
  end

end
