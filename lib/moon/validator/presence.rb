
# Value presence validator.
class Moon::Validator::Presence

  def messages(value, context)
    @value = value
    blank? ? [ "Must be present." ] : [ ]
  end

  private

  def blank?
    !@value || @value == ""
  end

end
