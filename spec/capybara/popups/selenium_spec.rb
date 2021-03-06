require 'spec_helper'

describe Prickle::Capybara::Popup do
  let(:prickly) { Prickly.new }

  before do
    Prickle::Capybara.wait_time = nil
  end

  before(:each) do
    prickly.visit '/'
  end

  context 'Managing selenium popups', :javascript => true do

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

    context "matching text" do
      it "can verify the content of a popup" do
        prickly.click_by_name "popups"
        prickly.popup_message_contains? "Hello"
        prickly.dismiss_popup
      end
    end
  end
end
