class AddForeignKeysToOfficesAndIndependentContractors < ActiveRecord::Migration
  def change
    add_foreign_key :independent_contractors, :offices
    add_foreign_key :offices, :distributorships
  end
end
