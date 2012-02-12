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

      class Expression
        CONTAINS = ".like"

        def initialize identifier, value
          @identifier = identifier
          @value = value
        end

        def to_s
          find_exact_match? ? MatchesValue.new(@identifier, @value).to_s : ContainsValue.new(@identifier, @value).to_s
        end

        private

        def find_exact_match?
          !@identifier.to_s.include? CONTAINS
        end

        def identifier
          @identifier
        end

        def attribute
          return identifier if identifier.eql? "text()"
          "@#{identifier}"
        end
      end


      class ContainsValue < XPath::Expression

        def to_s
          "contains(#{attribute}, '#{@value}')"
        end

        private

        def identifier
          @identifier.chomp '.like'
        end
      end


      class MatchesValue < XPath::Expression

        def to_s
          "#{attribute}='#{@value}'"
        end
      end
    end
  end
end

