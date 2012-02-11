require 'capybara/dsl'
require_relative 'actions'
require_relative 'exceptions'

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

      def find_element
        handle_exception { find_element_by xpath }
      end

      def find_element_by xpath
        wait_until(Prickle::Capybara.wait_time) do
          find(:xpath, xpath).visible?
        end unless Prickle::Capybara.wait_time.nil?

        find(:xpath, xpath)
      end

      def handle_exception &block
        begin
          block.call
        rescue Exception => e
          error_message = Error.new(@type, @identifier, @text, e).message
          raise ElementNotFound, error_message if e.class.to_s == "Capybara::ElementNotFound"
          raise
        end
      end

      def identifier
        return @identifier.each_pair.to_a.map { |k, v| "@#{k}='#{v}'" }.join " and "
      end

      def type
        CONVERTED_TYPES[@type.to_sym] || @type
      end

      def xpath
        xpath = "//#{type}[#{identifier}"
        xpath << " and contains(text(), '#{@text}')" if @text
        xpath << "]"
      end

      public

      include Prickle::Capybara::Actions

    end
  end
end
