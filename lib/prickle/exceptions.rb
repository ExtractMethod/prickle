require_relative 'exceptions/messages'

module Prickle
  module Exceptions

    def message
      @message
    end

    class ElementNotFound < Exception
      include Prickle::Exceptions

      def initialize(type, identifier, text, caught_exception)
        @message = Message::ElementNotFound.new(type, identifier, text, caught_exception).to_s
      end
    end

    class MessageNotContainedInPopup < Exception
      include Prickle::Exceptions

      def initialize message
        @message = Message::TextNotContainedInPopup.new(message).to_s
      end
    end
  end
end
