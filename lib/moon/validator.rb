
# Generic validator class. Can be used to validate model attributes.
class Moon::Validator

  autoload :Format, File.join(File.dirname(__FILE__), "validator", "format")
  autoload :Length, File.join(File.dirname(__FILE__), "validator", "length")
  autoload :Presence, File.join(File.dirname(__FILE__), "validator", "presence")

  attr_reader :model

  def initialize(model)
    @model = model
  end

  def ok?
    perform_checks
    @ok
  end

  def messages
    perform_checks
    @messages
  end

  private

  def perform_checks
    @ok, @messages = true, { }
    self.class.checks.each do |attribute, attribute_validator_class|
      perform_attribute_checks attribute, attribute_validator_class
    end
  end

  def perform_attribute_checks(attribute, attribute_validator_classes)
    attribute_validator_classes.each do |attribute_validator_class|
      attribute_validator = attribute_validator_class.new @model.send(attribute)
      ok, message = attribute_validator.ok?, attribute_validator.message
      @ok &&= ok
      add_message attribute, ok, message
    end
  end

  def add_message(attribute, ok, message)
    return if ok || !message
    @messages[attribute] ||= [ ]
    @messages[attribute] << message
  end

  def self.configuration=(value)
    @configuration = value
  end

  def self.configuration
    @configuration
  end

  def self.checks=(value)
    @checks = value
  end

  def self.checks
    @checks || { }
  end

  def self.[](model_class)
    validator = self.dup
    validator.checks = self.configuration[model_class]
    validator
  end

end
