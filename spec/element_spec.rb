require 'spec_helper'

describe Prickle::Capybara::Element do
  let(:prickly) { Prickly.new }

  before do
    prickly.visit '/'
  end

  it 'can find an element' do
    prickly.element(:name => 'blue').class.to_s.should == "Prickle::Capybara::Element"
  end

  it 'can match text in an element' do
    prickly.element(:name => 'yellow').contains_text? "Hello!"
  end

  it 'can match text in specific elements' do
    prickly.element(:li, :name => 'purple').contains_text? "Im not purple!"
  end

  it 'can match on link type elements' do
    prickly.element(:link, :name => 'orangey').contains_text? "Me too!"
  end

  it 'can click specific element types by name' do
    prickly.element(:paragraph, :name => 'yellow').click
  end

  it 'can find an element by type and identifier' do
    prickly.element(:paragraph, :id => 'coffee').exists?
  end

  it 'can find and click on element by type and identifier' do
    prickly.element(:link, :href => 'http://google.com').click
  end

  it 'can find an element by multiple identifiers' do
    prickly.element(:name => 'orangey', :class => 'pink').contains_text? "Blue hippos"
  end
end

