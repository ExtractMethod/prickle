module Prickle
  module Capybara
    module XPath

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

