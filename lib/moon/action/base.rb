
# Base class for all actions. It simply forces subclasses to implement a 'perform' method
# and makes the context available.
class Moon::Action::Base

  attr_reader :context

  def initialize(context)
    @context = context
  end

  def perform
    raise NotImplementedError, "method perform should be implemented in #{self.class}"
  end

end
