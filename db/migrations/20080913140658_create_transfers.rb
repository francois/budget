class CreateTransfers < ActiveRecord::Migration
  def self.up
    create_table :transfers do |t|
      t.date :posted_on, :null => false
      t.integer :debit_account_id, :credit_account_id, :null => false
      t.integer :amount_cents, :null => false
      t.string :comment
    end

    add_index :transfers, %w(posted_on), :name => :by_posted
    add_index :transfers, %w(debit_account_id posted_on), :name => :by_debit_posted
    add_index :transfers, %w(credit_account_id posted_on), :name => :by_credit_posted
  end

  def self.down
    drop_table :transfers
  end
end
