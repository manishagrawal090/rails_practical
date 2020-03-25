class BankAccountsController < ApplicationController

  def edit
    @type = params[:format]
    @account = BankAccount.find(params[:id])
  end

  def update
    @account = BankAccount.find(params[:id])
    if params[:bank_account][:amount].present?
      if  params[:type] == "deposit"
        balance = @account.balance.to_i + params[:bank_account][:amount].to_i
        if @account.update(balance: balance)
          redirect_to pages_home_path
          AccountTransaction.create(amount: params[:bank_account][:amount].to_i,transaction_type: "deposit",bank_account_id: @account.id)
        else
          render 'edit'
        end
      elsif params[:type] == "withdraw"
        if @account.balance.to_i >= params[:bank_account][:amount].to_i
          balance = @account.balance.to_i - params[:bank_account][:amount].to_i
          if @account.update(balance: balance)
            redirect_to pages_home_path
            AccountTransaction.create(amount: params[:bank_account][:amount].to_i,transaction_type: "withdraw",bank_account_id: @account.id)
          else
            render 'edit'
          end
        end
      elsif params[:type] == "transfer"
        balance = current_user.bank_accounts.first.balance - params[:bank_account][:amount].to_i
        if current_user.bank_accounts.first.update(balance: balance)
          user = User.find(params[:bank_account][:user].to_i)
          if user.bank_accounts.first.update(balance: user.bank_accounts.first.balance.to_i + params[:bank_account][:amount].to_i)
            redirect_to pages_home_path
            AccountTransaction.create(amount: params[:bank_account][:amount].to_i,transaction_type: "transfer",bank_account_id: current_user.bank_accounts.first.id)
          else
            render 'edit'
          end
        else
          render 'edit'
        end
      end
    else
      redirect_to pages_home_path
    end
  end

  def transfer_money
    @type = params[:format]
    @user = @user = User.all - [current_user]
    @bank = BankAccount.find(params[:bank_account_id])
  end

end
