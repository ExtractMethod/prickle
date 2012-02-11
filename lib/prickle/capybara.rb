require_relative 'capybara/element'

module Prickle
  TAGS = { :link => 'a',
    :paragraph => 'p'
  }

  module Capybara

    class << self
      attr_accessor :wait_time

    end

    def element type='*', identifier
      Element.new type, identifier
    end

    def find_by_name type='*', name
      element(type, :name => name).exists?
    end

    def click_by_name name
      find_by_name(name).click
    end

    private

    def method_missing method, *args
      if method =~ /(^.*)_contains_text\?$/
        element($1, :name => args.first).contains_text? args[1]
      elsif method =~ /^click_(.*)_by_name$/
        element($1, :name => args.first).click
      elsif method =~ /^find_(.*)_by_name$/
        element($1, :name => args.first).exists?
      else
        super
      end
    end

  end
end
