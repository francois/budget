class Account < ActiveRecord::Base
  Designations = %w(asset liability equity income expense).freeze

  validates_presence_of :name, :designation
  validates_inclusion_of :designation, :in => Designations

  has_many :debits, :class_name => "Transfer", :foreign_key => "debit_account_id"
  has_many :credits, :class_name => "Transfer", :foreign_key => "credit_account_id"

  def debit!(params={})
    self.debits.create!(:credit_account => params[:account], :posted_on => params[:on],
        :comment => params[:comment], :amount => params[:amount])
  end

  def credit!(params={})
    self.credits.create!(:debit_account => params[:account], :posted_on => params[:on],
        :comment => params[:comment], :amount => params[:amount])
  end

  def sum_of_debits
    cents = self.debits.sum(:amount_cents).to_i
    Money.new(cents, "CAD")
  end

  def sum_of_credits
    cents = self.credits.sum(:amount_cents).to_i
    Money.new(cents, "CAD")
  end
end
