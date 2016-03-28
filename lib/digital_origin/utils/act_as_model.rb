module DigitalOrigin
  module Utils
    module ActAsModel
      def all
        ObjectSpace.each_object(self).to_a
      end

      def count
        all.count
      end
    end
  end
end
