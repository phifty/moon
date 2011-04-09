
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
