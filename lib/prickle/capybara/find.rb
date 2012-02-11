module Prickle
  module Actions
    module Find

      def exists?
        find_element_by_identifier @type, @identifier
      end

    end
  end
end
