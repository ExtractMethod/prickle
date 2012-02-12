module Prickle
  module Capybara
    module XPath

      def self.with identifier, value
        XPath::Expression.new(identifier, value).to_s
      end

      private

      class Expression

        def initialize identifier, value
          @identifier = identifier
          @value = value
        end

        def to_s
          find_exact_match? ? MatchesValue.new(@identifier, @value).to_s : ContainsValue.new(@identifier, @value).to_s
        end

        private

        def find_exact_match?
          !@identifier.to_s.include?('.like')
        end

        def identifier
          @identifier
        end

        def attribute
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

