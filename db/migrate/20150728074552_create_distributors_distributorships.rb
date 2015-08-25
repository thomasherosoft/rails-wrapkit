class CreateDistributorsDistributorships < ActiveRecord::Migration
  def change
    create_join_table :distributors, :distributorships do |t|
      t.index :distributor_id
      t.index :distributorship_id
    end
  end
end
