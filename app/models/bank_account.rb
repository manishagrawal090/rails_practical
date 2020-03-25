class BankAccount < ApplicationRecord

  belongs_to :user
  has_many :account_transactions

  before_validation :load_defaults

  def to_s
    account_number
  end

  def load_defaults
    if self.new_record?
      self.balance = 0.00
    end
  end

end
