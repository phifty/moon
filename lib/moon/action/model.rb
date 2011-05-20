
module Moon::Action::Model

  autoload :Destroy, File.join(File.dirname(__FILE__), "model", "destroy")
  autoload :Index, File.join(File.dirname(__FILE__), "model", "index")
  autoload :Show, File.join(File.dirname(__FILE__), "model", "show")
  autoload :Store, File.join(File.dirname(__FILE__), "model", "store")

end
