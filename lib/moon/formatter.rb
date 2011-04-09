
# Model formatter
class Moon::Formatter

  autoload :Base, File.join(File.dirname(__FILE__), "formatter", "base")
  autoload :Generic, File.join(File.dirname(__FILE__), "formatter", "generic")

  def self.configuration=(value)
    @configuration = value
  end

  def self.configuration
    @configuration
  end

  def self.hash_for(model)
    formatter_class = (@configuration || { })[model.class]
    formatter_class ||= Moon::Formatter::Generic
    formatter_class.new(model).hash
  end

end
