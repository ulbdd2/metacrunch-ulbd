require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:testsuite) do |_task|
  _task.pattern = "testsuite/**{,/*/**}/*_spec.rb"
  _task.rspec_opts = "--default-path testsuite"
end

task :default => :spec
