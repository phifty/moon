
# Base class for a formatters.
class Moon::Formatter::Base

  attr_accessor :model

  def initialize(model)
    @model = model
  end

  def hash
    raise NotImplementedError, "method :hash has not been implemented"
  end

end
