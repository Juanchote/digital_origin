module DigitalOrigin
  class TransferRule
    extend DigitalOrigin::Utils::ActAsModel

    class << self
      def apply_rule(transfer)
        if transfer.from.bank == transfer.to.bank
          true
        else
          transfer.add_comission(5)
          raise "Quantity can not be greater than 1000" if transfer.quantity > 1000
          [true, true, false].sample
        end
      end
    end
  end
end
