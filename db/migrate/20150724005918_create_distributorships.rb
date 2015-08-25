class CreateDistributorships < ActiveRecord::Migration
  def change
    create_table :distributorships do |t|
      t.string :name, null: false
    end
  end
end
