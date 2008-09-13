class Account < ActiveRecord::Base
  Designations = %w(asset liability equity income expense).freeze

  validates_presence_of :name, :designation
  validates_inclusion_of :designation, :in => Designations
end
