
module Moon::Response

  autoload :Base, File.join(File.dirname(__FILE__), "response", "base")
  autoload :JSON, File.join(File.dirname(__FILE__), "response", "json")
  autoload :XML, File.join(File.dirname(__FILE__), "response", "xml")

end
