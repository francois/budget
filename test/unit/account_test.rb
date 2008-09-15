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

  def test_run_in_test_mode
    assert_equal :test, Sinatra.application.options.env
  end

  context "Existing accounts" do
    setup do
      @asset     = Account.create!(:name => "Bank Account #1", :designation => "asset")
      @liability = Account.create!(:name => "Credit Card #1", :designation => "liability")
      @equity    = Account.create!(:name => "Equity", :designation => "equity")
      @income    = Account.create!(:name => "Income", :designation => "income")
      @expense   = Account.create!(:name => "Groceries", :designation => "expense")
    end

    context "being used to reimburse a credit card" do
      setup do
        @asset.credit!(:account => @liability, :amount => "450 CAD".to_money, :on => Date.today)
      end

      should "have a total debit of 0 on the bank account" do
        assert_equal Money.zero, @asset.sum_of_debits
      end

      should "have a total credit of 450 on the bank account" do
        assert_equal "450 CAD".to_money, @asset.sum_of_credits
      end

      should "have a total debit of 450 on the credit card" do
        assert_equal "450 CAD".to_money, @liability.sum_of_debits
      end

      should "have a total credit of 0 on the credit card" do
        assert_equal Money.zero, @liability.sum_of_credits
      end
    end
  end
end
