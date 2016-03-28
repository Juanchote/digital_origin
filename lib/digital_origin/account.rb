module DigitalOrigin
  class Account
    extend DigitalOrigin::Utils::ActAsModel

    attr_reader :id, :bank, :money, :transfers

    OWNER_SAMPLES = %w(pepe juan manolo nuria marta)

    def initialize(options={})
      raise RuntimeError, "Account needs a bank" unless options[:bank]
      random      = Random.new
      @id         = "#{random.rand(10000)}-#{random.rand(10000)}-#{random.rand(100)}-#{random.rand(10000000000)}"
      @money      = options.fetch(:money) { 0 }
      @owner      = options.fetch(:owner) { OWNER_SAMPLES.sample }
      @bank       = options[:bank]
      @transfers  = []
    end

    def deposit(quantity)
      @money += quantity.abs
    end

    def substract(quantity)
      @money -= quantity
    end

    def transfer(destination, quantity)
      bank.transfer(self, destination, quantity)
    end

    def add_transfer(transfer)
      @transfers << transfer
    end
  end
end
