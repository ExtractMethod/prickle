require 'spec_helper'

describe Prickle::Capybara do
  let(:prickly) { Prickly.new }

  before do
    prickly.visit '/'
  end

  context 'finding elements' do
    it 'can find any element by name' do
      prickly.find_by_name 'red'
    end

    context 'can find by element type and name' do
      it 'can find a blue input type element' do
        prickly.find_input_by_name 'blue'
      end

      it 'can find a pink button' do
        prickly.find_button_by_name 'pink'
      end

      it "but it cannot find a pink link because it's not on the page" do
        expect { prickly.find_a_by_name('pink') }.to raise_error
      end
    end

    it 'can find a link' do
      prickly.find_link_by_name 'red-dots'
    end
  end

  context 'clicking on elements' do
    it 'can click any element by name' do
      prickly.click_by_name 'blue'
    end

    it 'can click any element by name and type' do
      prickly.element(:input, :name => 'blue').click
    end

    context 'can click by element type and name' do
      it 'can find a blue input type element' do
        prickly.click_input_by_name 'blue'
      end

      it "but it cannot find a blue link because it's not on the page" do
        expect { prickly.click_link_by_name 'blue' }.to raise_error
      end
    end
  end

  context 'matching text' do
    it 'can find text in a paragraph' do
      prickly.paragraph_contains_text? "yellow", "Hello!"
    end
  end
end
