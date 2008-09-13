# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080913140658) do

  create_table "accounts", :force => true do |t|
    t.string "name",        :limit => 64, :null => false
    t.string "designation", :limit => 10, :null => false
  end

  add_index "accounts", ["name"], :name => "by_name", :unique => true

  create_table "transfers", :force => true do |t|
    t.date    "posted_on"
    t.integer "origin_account_id"
    t.integer "destination_account_id"
    t.integer "amount_cents"
  end

  add_index "transfers", ["destination_account_id"], :name => "index_transfers_on_destination_account_id"
  add_index "transfers", ["origin_account_id"], :name => "index_transfers_on_origin_account_id"
  add_index "transfers", ["posted_on"], :name => "by_posted"

end
