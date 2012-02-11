require File.join(File.dirname(__FILE__), "..", "lib", "prickle", "capybara")

require 'rspec'
require 'prickle/capybara'

class Prickly
  include Capybara::DSL
  include Prickle::Capybara

end

require_relative 'stub/app'
Capybara.app = Sinatra::Application
Capybara.default_wait_time = 0
