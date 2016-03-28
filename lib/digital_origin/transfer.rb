module DigitalOrigin
  class Transfer
    extend DigitalOrigin::Utils::ActAsModel

    attr_reader :quantity, :from, :to, :transfer_rule, :commission, :success

    def initialize(options)
      @from = options[:from]
      @to = options[:to]
      @quantity = options[:quantity]
      @transfer_rule = nil
      @commission = 0
      @success = true

      call
    end

    def origin_bank
      @from.bank
    end

    def destination_bank
      @to.bank
    end

    def add_comission(quantity)
      @commission = quantity
    end

    def call
      @success = apply_rule
      return "Error" unless @success
      @from.substract(quantity + @commission)
      @to.deposit(quantity - @commission)
      @success
    end

    private
    def apply_rule
      TransferRule.apply_rule(self)
    end
  end
end
