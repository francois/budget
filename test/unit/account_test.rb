require File.dirname(__FILE__) + "/../test_helper"

class AccountTest < Test::Unit::TestCase
  context "A new Account" do
    setup do
      @account = Account.new
    end

    should "be invalid" do
      deny @account.valid?
    end

    should "have an invalid name" do
      @account.valid?
      assert_not_empty @account.errors.on(:name)
    end

    should "have an invalid designation" do
      @account.valid?
      assert_not_empty @account.errors.on(:designation)
    end

    context "with a name" do
      should "have a valid name" do
        @account.name = "My Account"
        @account.valid?
        assert_nil @account.errors.on(:name)
      end
    end

    context "with a designation" do
      should "have a valid designation" do
        @account.designation = "liability"
        @account.valid?
        assert_nil @account.errors.on(:designation)
      end

      should "be invalid when the designation is 'foo'" do
        @account.designation = "foo"
        @account.valid?
        assert_not_empty @account.errors.on(:designation)
      end
    end
  end
end
