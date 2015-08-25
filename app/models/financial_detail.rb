class FinancialDetail < ActiveRecord::Base
  belongs_to :address
  belongs_to :financial_institution
end
