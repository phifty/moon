# encoding: utf-8

Gem::Specification.new do |specification|
  specification.name              = "moon"
  specification.version           = "0.0.3"
  specification.date              = "2011-06-23"

  specification.authors           = [ "Philipp Brüll" ]
  specification.email             = "b.phifty@gmail.com"
  specification.homepage          = "http://github.com/phifty/moon"
  specification.rubyforge_project = "moon"

  specification.summary           = "Moon - A rack application library."
  specification.description       = "A simple rack application library - alpha release."

  specification.has_rdoc          = true
  specification.files             = [ "README.rdoc", "LICENSE", "Rakefile" ] + Dir["lib/**/*"] + Dir["spec/**/*"]
  specification.extra_rdoc_files  = [ "README.rdoc" ]
  specification.require_path      = "lib"

  specification.test_files        = Dir["spec/**/*_spec.rb"]

  specification.add_dependency "sinatra", ">= 1.2.0"
  specification.add_dependency "configure", ">= 0.3.0"
  specification.add_dependency "gom", ">= 0.4.1"

  specification.add_development_dependency "rspec", ">= 2"
  specification.add_development_dependency "reek", ">= 1.2"
end
