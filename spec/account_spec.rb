require 'spec_helper'

describe DigitalOrigin::Account do
  let(:bank) do
    DigitalOrigin::Bank.new
  end

  context 'creating account' do
    xit 'raises Exception with no bank' do
      expect(DigitalOrigin::Account.new).to raise_exception(RuntimeError, "Account needs a bank")
    end


    it 'works with bank' do
      expect(bank.create_account.class).to be(DigitalOrigin::Account)
    end
  end

  context 'money stuff' do
    let(:account) do
      bank.create_account(money: 1000)
    end

    it "deposit 100" do
      expect{ account.deposit(100) }.to change{account.money}.by(100)
    end

    it 'substract 100' do
      expect{ account.substract(100) }.to change{ account.money}.by(-100)
    end
  end
end
