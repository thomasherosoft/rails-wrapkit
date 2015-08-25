class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.integer :duration, null: true
      t.boolean :good, null: false
      t.boolean :service,  null: false
      t.string :product_type, null: false
      t.string :product_sub_type, null: false
      t.string :product, null: false
      t.string :model, null: false
      t.string :serial, null: false
      t.boolean :install_required, null: false
      t.integer :install_duration,   null: true
      t.string :supplier, null: false
      t.string :additional_components, null: true
      t.boolean :active, null: true
      t.timestamps null: false
    end
  end
end
