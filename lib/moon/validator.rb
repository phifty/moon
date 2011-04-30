
# Generic validator class. Can be used to validate model attributes.
class Moon::Validator

  autoload :Format, File.join(File.dirname(__FILE__), "validator", "format")
  autoload :Length, File.join(File.dirname(__FILE__), "validator", "length")
  autoload :Presence, File.join(File.dirname(__FILE__), "validator", "presence")

  attr_reader :model_class

  def initialize(checks)
    @checks = checks
  end

  def messages(model)
    perform_checks model
    @messages
  end

  private

  def perform_checks(model)
    @messages = { }
    @checks.each do |attribute, attribute_validator|
      value = model.send attribute
      perform_attribute_checks attribute, value, [ attribute_validator ].compact.flatten
    end
  end

  def perform_attribute_checks(attribute, value, attribute_validators)
    attribute_validators.each do |attribute_validator|
      messages = attribute_validator.messages value
      add_messages attribute, messages
    end
  end

  def add_messages(attribute, messages)
    return if messages.empty?
    @messages[attribute] ||= [ ]
    @messages[attribute] += messages
  end

end
