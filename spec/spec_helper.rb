require File.join(File.dirname(__FILE__), "..", "lib", "prickle", "capybara")

require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'prickle/capybara'

class Prickly
  include Capybara::DSL

end

require_relative 'stub/app'
Capybara.app = Sinatra::Application
Capybara.default_wait_time = 0
