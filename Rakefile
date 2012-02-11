require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_path = 'rspec'
  t.rspec_opts = %w[-cfd]
end

task :default => :spec
