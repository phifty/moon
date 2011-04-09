
module Moon::Utility::String

  def self.camelize(lower_case_and_underscored_word)
    lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1}".upcase }.gsub(/(?:^|_)(.)/) { $1.upcase }
  end

  def self.underscore(camel_cased_word)
    camel_cased_word.to_s.
      gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr("-", "_").
      downcase
  end

end
