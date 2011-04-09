
# Value format validator.
class Moon::Validator::Format
  extend Moon::Utility::Template

  template :format

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
    @ok = @value =~ self.class.format
    @message = "Has a wrong format." unless @ok
  end

end
