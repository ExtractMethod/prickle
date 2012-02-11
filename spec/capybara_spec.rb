require 'spec_helper'

describe Prickle::Capybara do
  let(:prickly) { Prickly.new }

  before do
    Capybara.default_driver = :selenium
    Prickle::Capybara.wait_time = nil
  end

  before(:each) do
    prickly.visit '/'
  end

  context 'Managing popups', :javascript => true do

    it 'can confirm an alert box' do
      prickly.click_by_name 'popups'
      prickly.confirm_popup
    end

    it 'can confirm a popup' do
      prickly.click_by_name 'confirm_box'
      prickly.confirm_popup
    end

    it 'can dismiss a popup' do
      prickly.click_by_name 'confirm_box'
      prickly.dismiss_popup
      prickly.popup_message.should eq "Aborting."
      prickly.confirm_popup
    end
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
