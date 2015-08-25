class Distributorship < ActiveRecord::Base
  has_many :independent_contractors, through: :offices
  has_many :offices
  has_and_belongs_to_many :distributors
end
