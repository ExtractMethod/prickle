require 'capybara/dsl'
require_relative 'xpath'
require_relative 'actions'

module Prickle
  module Capybara
    class Element

      include ::Capybara::DSL

      OF_ANY_TYPE = "*"
      CONVERTED_TYPES = { :link => 'a',
                          :paragraph => 'p'
                        }

      private

      def initialize type=OF_ANY_TYPE, identifier
        @identifier = identifier
        @type = type
        self
      end

      def identifier
        @identifier
      end

      def type
        CONVERTED_TYPES[@type.to_sym] || @type
      end

      def find_element
        handle_exception { find_element_by_xpath }
      end

      def xpath
        XPath::for_element_with type, identifier
      end

      def find_element_by_xpath
        wait_until(Capybara.wait_time) do
          find(:xpath, xpath).visible?
        end unless Capybara.wait_time.nil?

        find :xpath, xpath
      end

      def handle_exception &block
        begin
          block.call
        rescue Exception => e
          raise element_not_found(e) if e.class == ::Capybara::ElementNotFound
          raise
        end
      end

      def element_not_found caught_exception
        Exceptions::ElementNotFound.new(@type, identifier, @text, caught_exception)
      end

      public

      include Prickle::Capybara::Actions

    end
  end
end
