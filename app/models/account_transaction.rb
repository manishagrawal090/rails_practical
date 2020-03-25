class AccountTransaction < ApplicationRecord
  belongs_to :bank_account

  before_validation :load_defaults

  def load_defaults
    if self.new_record?
      self.transaction_number = SecureRandom.uuid
    end
  end
end
