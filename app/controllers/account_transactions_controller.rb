class AccountTransactionsController < ApplicationController

  def index
    @transaction = AccountTransaction.where(bank_account_id: current_user.bank_accounts.first.id)
  end
end
