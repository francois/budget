class Transfer < ActiveRecord::Base
  validates_presence_of :posted_on, :debit_account_id, :credit_account_id, :amount_cents

  belongs_to :debit_account, :class_name => "Account"
  belongs_to :credit_account, :class_name => "Account"

  composed_of :amount, :class_name => "Money", :mapping => %w(amount_cents cents)
end
