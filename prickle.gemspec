$:.push File.expand_path("../lib", __FILE__)
require "prickle/version"

Gem::Specification.new do |s|
  s.name        = "prickle"
  s.version     = Prickle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = "Despo Pentara"
  s.email       = "despo@extractmethod.com"
  s.homepage    = "https://github.com/ExtractMethod/prickle"
  s.summary     = "A simple DSL extending Capybara."
  s.description = "A simple DSL extending Capybara."
  s.required_ruby_version = '>= 1.9.2'

  s.licenses = ["MIT"]

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {spec}/*`.split("\n")
  s.executables        = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths      = ["lib"]

  s.add_dependency "capybara"

  s.add_development_dependency "capybara"
  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "sinatra", "~> 1.3.2"
  s.add_development_dependency "rake"
  s.add_development_dependency "reek"
end

