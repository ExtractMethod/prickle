require 'spec_helper'

describe Prickle::Capybara do
  let(:prickly) { Prickly.new }

  before do
    Capybara.default_driver = :selenium
    Prickle::Capybara.wait_time = nil
    prickly.visit '/'
  end

  context 'Screenshots', :javascript => true do

    it 'can capture the screen' do
      screenshot_name = Time.now.strftime("%Y%m%d-%H.%M.%s")
      prickly.capture_screen screenshot_name
      `ls #{Prickle::Capybara.image_dir}`.should include "#{screenshot_name}"
    end

    after do
      `rm -f #{Prickle::Capybara.image_dir}/*.jpg`
    end
  end
end
