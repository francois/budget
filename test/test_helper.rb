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
  def logger
    ActiveRecord::Base.logger
  end

  def run_with_transaction(*args, &block)
    begin
      logger.debug {"==> Running #{name} <=="}
      ActiveRecord::Base.transaction do
        run_without_transaction(*args, &block)
        raise EnsureRollback
      end
    rescue EnsureRollback
      # NOP
    ensure
      logger.debug {"==> Done running #{name} <=="}
    end
  end

  alias_method_chain :run, :transaction
  class EnsureRollback < RuntimeError; end
end
