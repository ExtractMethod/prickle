module Prickle
  module Capybara
    module XPathFor

      def self.contains_value key, value
        ContainsValue.new(key, value).to_s
      end

      private

      def initialize key, value
        @key = key
        @value = value
      end

      class ContainsValue
        include XPathFor

        def key
          @key.chomp '.like'
        end

        def to_s
          "contains(@#{key}, '#{@value}')"
        end

      end
    end
  end
end

