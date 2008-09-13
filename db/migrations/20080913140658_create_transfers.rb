class CreateTransfers < ActiveRecord::Migration
  def self.up
    create_table :transfers do |t|
      t.date :posted_on
      t.integer :origin_account_id, :destination_account_id
      t.integer :amount_cents
    end

    add_index :transfers, %w(posted_on), :name => :by_posted
    add_index :transfers, %w(origin_account_id)
    add_index :transfers, %w(destination_account_id)
  end

  def self.down
    drop_table :transfers
  end
end
