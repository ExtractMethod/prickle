require_relative 'actions'
require_relative 'exceptions'

module Prickle
  module Capybara
    class Element

      require 'capybara/dsl'
      include ::Capybara::DSL

      private

      def initialize type="*", identifier
        @identifier = identifier
        @type = type
        self
      end

      def xpath
        xpath = "//#{type}[#{identifier}"
        xpath << " and contains(text(), '#{@text}')" if @text
        xpath << "]"
      end

      def handle_exception &block
        begin
          block.call
        rescue Exception => e
          raise ElementNotFound, Error.new(@type, @identifier, @text, e).message if e.class.to_s == "Capybara::ElementNotFound"
          raise
        end
      end

      def identifier
        return @identifier.each_pair.to_a.map { |k, v| "@#{k}='#{v}'" }.join " and "
      end

      def find_element_by xpath
        wait_until(Prickle::Capybara.wait_time) do
          find(:xpath, xpath).visible?
        end unless Prickle::Capybara.wait_time.nil?

        find(:xpath, xpath)
      end

      def find_element
        handle_exception { find_element_by xpath }
      end

      def type
        Prickle::TAGS[@type.to_sym] || @type
      end

      public

      include Prickle::Capybara::Actions

    end

  end
end
