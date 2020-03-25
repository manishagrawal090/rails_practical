class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bank_accounts
  before_save :format_name
  after_create :create_bank_account

  def format_name
    self.name = self.name.upcase
  end

  def num_accounts
    self.bank_accounts.count
  end

  def create_bank_account
    self.bank_accounts.create(account_number: rand(11 ** 11))
  end

end
