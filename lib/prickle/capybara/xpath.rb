require_relative 'xpath/expression'
module Prickle
  module Capybara
    module XPath

      def self.for_element_with type, identifier
        XPath::Element.new(type,identifier).to_s
      end

      private

      class Element
        def initialize type, identifier
          @type = type
          @identifier = identifier
        end

        def to_s
          "//#{@type}[#{identifier}]"
        end

        def identifier
          return @identifier.each_pair.inject([]) do |xpath_str, (key, value)|
            xpath_str << XPath::Expression.new(key, value).to_s
          end.join " and "
        end
      end

    end
  end
end

