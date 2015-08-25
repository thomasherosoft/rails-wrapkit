class CreateIcSubtypes < ActiveRecord::Migration
  def change
    create_table :ic_subtypes do |t|
      t.timestamps null: false
    end
  end
end
