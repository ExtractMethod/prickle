require 'spec_helper'

describe Prickle::Capybara::Popup do
  let(:prickly) { Prickly.new }

  before do
    Capybara.default_driver = :webkit
    Prickle::Capybara.wait_time = nil
  end

  before(:each) do
    prickly.visit '/'
  end

  context 'Managing webkit popups', :js => true do
    it 'can confirm an alert box' do

     alert = prickly.popup.accept_alert {
        prickly.click_by_name 'popups'
     }

     alert.contains_message? "Hello"
    end

    it 'can confirm a popup' do
      alert = prickly.popup.accept {
        prickly.click_by_name 'confirm_box'
      }
      alert.contains_message? "Click yes to continue"
    end

    it 'can dismiss a popup' do
      alert = prickly.popup.dismiss {
        prickly.click_by_name 'confirm_box'
      }

      alert.contains_message? "Click yes to continue"
    end

  end
end
