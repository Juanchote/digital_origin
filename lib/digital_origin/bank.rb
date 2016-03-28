module DigitalOrigin
  class Bank
    extend DigitalOrigin::Utils::ActAsModel

    NAME_SAMPLES = %w( bbva ing sabadell santander )
    attr_accessor :accounts, :transfers

    def initialize(options={})
      @name = options.fetch(:name) { NAME_SAMPLES.sample }
      @accounts = []
      @transfers = []
    end

    def create_account(options={})
      Account.new(options.merge(bank: self)).tap do |acc|
        @accounts << acc
      end
    end

    def transfer(origin, destination, quantity)
      dest_acc = self.class.all.flat_map do |bank|
        bank.accounts.detect{ |acc| acc.id == destination }
      end.compact.first

      if dest_acc
        create_transfer(origin, dest_acc, quantity)
      else
        raise "Destination Account does not exist" unless dest_acc
      end
    end

    def create_transfer(origin, destination, quantity)
      transfer = Transfer.new(from: origin, to: destination, quantity: quantity)

      if transfer
        add_transfer(origin, transfer)
        if self != destination.bank
          add_transfer(destination, transfer)
        end
      end
    end

    def add_transfer(account, transfer)
      @transfers << transfer
      account.add_transfer(transfer)
    end
  end
end
