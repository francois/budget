require "test/unit"
require "budget"
require "shoulda"
require "active_record/fixtures"

# Prevent Sinatra from starting after the tests are done
Sinatra.application.options.run = false

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
