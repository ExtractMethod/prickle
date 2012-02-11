require 'spec_helper'

describe Prickle::Capybara do
  let(:prickly) { Prickly.new }

  before do
    Capybara.default_driver = :selenium
  end

  context 'Extended waits', :javascript => true do

    before(:each) do
      Prickle::Capybara.wait_time = nil
      prickly.visit '/'
    end

    context "matching text" do
      it 'can wait for an element to appear' do
        Prickle::Capybara.wait_time = 4
        prickly.element(:name => 'lagged').contains_text? "I lag"
      end

      it "can fail if an element doesn't appear after the default wait time" do
        Prickle::Capybara.wait_time = 2
        expect { prickly.element(:name => 'lagged').contains_text? "I lag" }.to raise_error Capybara::TimeoutError
      end
    end

    context "finding elements" do
      it 'can wait for an element to appear' do
        Prickle::Capybara.wait_time = 4
        prickly.find_by_name('lagged')
      end
    end

    context "clicking elements" do
      it 'fails to click an element that has not appeared yet' do
        Prickle::Capybara.wait_time = 1
        expect { prickly.click_by_name('lagged') }.to raise_error Capybara::TimeoutError
      end

      it 'can click an element after it appears' do
        Prickle::Capybara.wait_time = 4
        prickly.click_by_name('lagged')
      end
    end
  end
end
