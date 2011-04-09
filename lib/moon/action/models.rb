
module Moon::Action::Models

  autoload :Finder, File.join(File.dirname(__FILE__), "models", "finder")
  autoload :Initializer, File.join(File.dirname(__FILE__), "models", "initializer")
  autoload :Updater, File.join(File.dirname(__FILE__), "models", "updater")

end
