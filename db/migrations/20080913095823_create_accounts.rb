class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :name, :limit => 64, :null => false
    end

    add_index :accounts, %w(name), :unique => true, :name => :by_name
  end

  def self.down
    drop_table :accounts
  end
end
