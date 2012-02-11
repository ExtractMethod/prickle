require_relative 'find'
require_relative 'click'
require_relative 'match'
require_relative 'exceptions'

module Prickle
  module Capybara
    class Element

      require 'capybara/dsl'
      include ::Capybara::DSL

      def initialize type="*", identifier
        @identifier = identifier
        @type = type
        self
      end

      def handle_exception &block
        begin
          block.call
        rescue Exception => e
          raise Capybara::ElementNotFound.new(@type, @identifier, @text, e) if e.class.to_s == "Capybara::ElementNotFound"
          raise
        end
      end

      def xpath_for identifier
        return identifier.each_pair.to_a.map do |key, value|
          "@#{key}='#{value}'"
        end.join ' and '
      end

      def find_element_by xpath
        wait_until(Prickle::Capybara.wait_time) do
          find(:xpath, xpath).visible?
        end unless Prickle::Capybara.wait_time.nil?

        find(:xpath, xpath)
      end

      def type_of element
        Prickle::TAGS[element.to_sym] || element
      end

      include Prickle::Actions::Find
      include Prickle::Actions::Match
      include Prickle::Actions::Click

    end

  end
end
