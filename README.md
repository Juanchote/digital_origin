# DigitalOrigin

# USAGE

´bundle console´ to run the gem (didn't had enough time to thorize it).

´DigitalOrigin::Bank.new´ Creates a new random bank.
optionals args
  name: Bank name

´<new_bank>.create_account´ Creates a new Account
optional args
  money: account money
  owner: owner name

´<account>.deposit(quantity)´ adds money to the account
´<account>.substract(quantity)´ substract money from account

´<account>.transfer(<other_account>.id, quantity)´ transfers money between accounts.

Tests may randomly fails when running InterBank transfer due to the 30% fails prob.

´<bank>.transfers´ shows all bank transfers
´<account>.transfers´ shows all transfers from/to that account


