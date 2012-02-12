module Prickle
  module Exceptions
    module Message

      private
      def highlight text
        "\e[1m#{text}\e[0m\e[31m"
      end

      class ElementNotFound
        include Message

        def initialize type=nil, identifier=nil, text=nil, caught_exception=nil
          @element_type = type
          @element_identifier = identifier
          @element_text = text
          @caught_exception = caught_exception
        end

        def to_s
          "#{element_text} with identifier #{identifier}#{text_string} was not found.\n\tError: #{@caught_exception.message}"
        end

        private

        def element_text
          return highlight(@element_type) unless @element_type == "*"
          "Element"
        end

        def text_string
          " and text #{highlight(@element_text)}" unless @element_text.nil?
        end

        def identifier
          highlight(@element_identifier.to_s)
        end
      end

      class TextNotContainedInPopup
        include Message

        def initialize message
          @message = message
        end

        def to_s
          "Text #{highlight(@message)} is not contained in the popup."
        end
      end

    end

  end
end
