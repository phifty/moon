
# The action responses a blank json response without any conditions.
class Moon::Action::RespondBlank

  def perform(context)
    Moon::Response::JSON::Blank.new
  end

end
