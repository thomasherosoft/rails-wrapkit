class AddForeignKeysToDistributorsDistributorships < ActiveRecord::Migration
  def change
    add_foreign_key :distributors_distributorships, :distributors
    add_foreign_key :distributors_distributorships, :distributorships
  end
end
