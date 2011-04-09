require 'rake/rdoctask'

# RSpec
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = [ "--colour" ]
end

namespace :spec do

  RSpec::Core::RakeTask.new(:profile) do |task|
    task.rspec_opts = [ "--colour", "--profile" ]
  end

end

# Reek
require 'reek/rake/task'

Reek::Rake::Task.new do |task|
  task.source_files = "lib/**/*.rb"
end

# RDoc

desc "Generate the rdoc"
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_files.add [ "README.rdoc", "lib/**/*.rb" ]
  rdoc.main = "README.rdoc"
  rdoc.title = ""
end

# Gem

namespace :gem do

  desc "Builds the gem"
  task :build do
    system "gem build *.gemspec && mkdir -p pkg/ && mv *.gem pkg/"
  end

  desc "Builds and installs the gem"
  task :install => :build do
    system "gem install pkg/"
  end

end
