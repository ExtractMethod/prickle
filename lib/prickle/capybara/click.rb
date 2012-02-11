module Prickle
  module Actions
    module Click

      def click
        find_element_by_identifier(@type, @identifier).click
      end
    end
  end
end
