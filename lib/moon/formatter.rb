
# Model formatter
class Moon::Formatter

  autoload :Generic, File.join(File.dirname(__FILE__), "formatter", "generic")

  def self.hash_for(formatters, model)
    formatter = formatters[model.class]
    formatter ||= Moon::Formatter::Generic.new
    formatter.hash model
  end

end
