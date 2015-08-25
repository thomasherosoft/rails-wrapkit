class AddRedundantPolymorphicTables < ActiveRecord::Migration
  def change
    create_table :user_subtypes
  end
end
