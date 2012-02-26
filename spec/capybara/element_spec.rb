require 'spec_helper'

describe Prickle::Capybara::Element do
  let(:prickly) { Prickly.new }

  before do
    prickly.visit '/'
  end

  it 'can find an element' do
    prickly.element(:name => 'blue').class.to_s.should == "Prickle::Capybara::Element"
  end

  context "Matchers" do

    it 'can match text in an element' do
      prickly.element(:name => 'yellow').contains_text? "Hello!"
    end

    it 'can match on link type elements' do
      prickly.element(:link, :name => 'orangey').contains_text? "Me too!"
    end

    it 'can find and click on element by type and identifier' do
      prickly.element(:link, :href => 'http://google.com').exists?
    end

    it 'can find an element by multiple identifiers' do
      prickly.element(:name => 'orangey', :class => 'pink').contains_text? "Blue hippos"
    end

    it 'can find an element by a string contained in its identifier' do
      prickly.element(:name.like => 'purpli').contains_text? "erm"
    end

    it 'can find an element by a contained and an exact match in its identifier' do
      prickly.element(:name.like => 'purpli', :id => 'one').contains_text? "erm"
    end

  end

  context "#click" do

    it 'can click specific element types by name' do
      prickly.element(:paragraph, :name => 'yellow').click
    end
  end

  context "#contains_text" do

    it 'can check if text is included in an element' do
      prickly.element(:li, :name => 'purple').contains_text? "Im not purple!"
    end
  end

  context "#has_text?" do

    it "can match the text in an element" do
      prickly.element(:name => 'gum').has_text? "bubblegum"
    end
  end

  context "#exists?" do

    it 'can find an element by type and identifier' do
      prickly.element(:paragraph, :id => 'coffee').exists?
    end
  end
end
