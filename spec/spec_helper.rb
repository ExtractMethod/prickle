require File.join(File.dirname(__FILE__), "..", "lib", "prickle", "capybara")

require 'rspec'
require 'capybara/rspec'
require 'capybara-webkit'
require 'prickle/capybara'

class Prickly
  include Capybara::DSL
  include Prickle::Capybara

end

require_relative 'stub/app'
Capybara.app = Sinatra::Application
Capybara.default_wait_time = 0
Prickle::Capybara.image_dir = File.dirname(__FILE__) + "/tmp/"
Capybara.default_driver = :selenium
