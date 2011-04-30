
# Value format validator.
class Moon::Validator::Format

  def initialize(format)
    @format = format
  end

  def messages(value)
    value =~ @format ? [ ] : [ "Has a wrong format." ]
  end

end
