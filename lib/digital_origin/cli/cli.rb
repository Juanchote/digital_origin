require 'thor'

#TODO CLI
module DigitalOrigin
  class Cli < Thor
    desc "creates_bank", "Creates a new bank"
    def create_bank
        @banks = DigitalOrigin::Bank.new
    end
  end
end
