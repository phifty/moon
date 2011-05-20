
module Moon::Action::Model

  autoload :Create, File.join(File.dirname(__FILE__), "model", "create")
  autoload :Destroy, File.join(File.dirname(__FILE__), "model", "destroy")
  autoload :Index, File.join(File.dirname(__FILE__), "model", "index")
  autoload :Show, File.join(File.dirname(__FILE__), "model", "show")
  autoload :Update, File.join(File.dirname(__FILE__), "model", "update")
  autoload :UpdateOrCreate, File.join(File.dirname(__FILE__), "model", "update_or_create")

end
