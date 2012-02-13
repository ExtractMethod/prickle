require 'capybara/dsl'
require_relative 'xpath'
require_relative 'actions'

module Prickle
  module Capybara
    class Element

      include ::Capybara::DSL
      include Prickle::Capybara::Actions

      OF_ANY_TYPE = "*"
      CONVERTED_TYPES = { :link => 'a',
                          :paragraph => 'p'
                        }

      private

      MISSING_METHOD_REGEX = /(^.*)_(contains_text\?)|(click|find)_(.*)_by_name/

      def initialize type=OF_ANY_TYPE, identifier
        @identifier = identifier
        @type = type
        self
      end

      def identifier
        @identifier
      end

      def type_as_tag
        CONVERTED_TYPES[@type.to_sym] || @type
      end

      def find_element
        handle_exception { find_element_by_xpath }
      end

      def find_element_by_xpath
        wait_until(Capybara.wait_time) do
          find(:xpath, xpath).visible?
        end unless Capybara.wait_time.nil?

        find :xpath, xpath
      end

      def xpath
        XPath::for_element_with type_as_tag, identifier
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

      def self.extract_method_missing properties
        element = { }
        element[:method] = properties[1] || properties[2]
        element[:args] = properties[4][1]
        element
      end
    end
  end
end
