require 'spec_helper'

describe Prickle::Capybara do
  let(:prickly) { Prickly.new }

  before do
    Capybara.default_driver = :selenium
    Prickle::Capybara.wait_time = nil
  end

  context 'Managing popups' do

    before(:each) do
      prickly.visit '/'
    end

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
    end
  end
end
