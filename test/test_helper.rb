require "test/unit"
require "budget"
require "shoulda"
require "active_record/fixtures"
require "sinatra/test/unit"

module Test::Unit::Assertions
  def deny(boolean, message = nil)
    message = build_message message, '<?> is not false or nil.', boolean
    assert_block message do
      not boolean
    end
  end

  def assert_empty(collection, message = nil)
    assert_respond_to collection, :empty?
    message = build_message message, '<?> is not empty', collection.empty?
    assert_block message do
      collection.empty?
    end
  end

  def assert_not_empty(collection, message = nil)
    assert_respond_to collection, :empty?
    message = build_message message, '<?> is empty', collection.empty?
    assert_block message do
      not collection.empty?
    end
  end
end

class Test::Unit::TestCase
  setup :begin_db_transaction
  teardown :rollback_db_transaction

  def begin_db_transaction
    ActiveRecord::Base.send :increment_open_transactions
    ActiveRecord::Base.connection.begin_db_transaction
  end

  def rollback_db_transaction
    ActiveRecord::Base.send :decrement_open_transactions
    ActiveRecord::Base.connection.rollback_db_transaction
  end

  def logger
    ActiveRecord::Base.logger
  end
end
