
# Value presence validator.
class Moon::Validator::Presence

  attr_accessor :value

  def initialize(value)
    @value = value
    @ok, @message = true, nil
  end

  def ok?
    check
    @ok
  end

  def message
    check
    @message
  end

  private

  def check
    @ok = @value && @value != ""
    @message = "Must be present." unless @ok
  end

end
