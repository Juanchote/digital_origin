require 'spec_helper'

describe DigitalOrigin::Bank do
  context 'creating bank' do
    it 'works' do
        expect{ DigitalOrigin::Bank.new }.to change{ DigitalOrigin::Bank.count}.by(1)
    end
  end

  context 'create accounts' do
    let(:bank) do
      DigitalOrigin::Bank.new
    end
    it "creates account with 0 money" do
        expect{  bank.create_account }.to change{ bank.accounts.count}.by(1)
      expect(bank.accounts.first.money).to eq(0)
    end

    it 'create account with 100' do
        expect{  bank.create_account(money: 100) }.to change{ bank.accounts.count}.by(1)
      expect(bank.accounts.last.money).to eq(100)
    end
  end

  context 'intra transfers' do
    let(:bank) do
        DigitalOrigin::Bank.new
    end
    let(:acc_a) do
      bank.create_account(money: 100)
    end

    let(:acc_b) do
      bank.create_account
    end

    it "money" do
      expect{ acc_a.transfer(acc_b.id, 100) }.to change{ acc_a.money }.by(-100)
      expect{ acc_a.transfer(acc_b.id, 100) }.to change{ acc_b.money }.by(100)
    end

    it "count all transfers" do
      acc_a.transfer(acc_b.id, 100)
      acc_a.transfer(acc_b.id, 100)
      expect(bank.transfers.count).to eq(2)
    end

    it "list one account transfers count" do
      acc_a.transfer(acc_b.id, 100)
      expect(acc_a.transfers.count).to eq(1)
    end
  end

  context 'inter transfers' do
    let(:bank_a) do
      DigitalOrigin::Bank.new
    end

    let(:bank_b) do
      DigitalOrigin::Bank.new
    end
    let(:acc_a) do
      bank_a.create_account(money: 100)
    end

    let(:acc_b) do
      bank_b.create_account
    end

    it "money" do
      expect{ acc_a.transfer(acc_b.id, 100) }.to change{ acc_a.money }.by(-105)
      expect{ acc_a.transfer(acc_b.id, 100) }.to change{ acc_b.money }.by(95)
    end

    it "count all transfers" do
      acc_a.transfer(acc_b.id, 100)
      acc_a.transfer(acc_b.id, 100)
      expect(bank_a.transfers.count).to eq(4)
    end

    it "list one account transfers count" do
      acc_a.transfer(acc_b.id, 100)
      expect(acc_a.transfers.count).to eq(1)
    end
  end

end
