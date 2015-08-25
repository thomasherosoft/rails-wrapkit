class CreateCustomerProducts < ActiveRecord::Migration
  def change
    create_table :customer_products do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :application_number
      t.integer :status
      t.references :program, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.float :price
      t.boolean :hst
      t.boolean :free
      t.string :serial_number
      t.string :model_number
      t.integer :cp_type
      t.string :coil_serial_number
      t.string :coil_model_number
      t.date :purchase_date
      t.boolean :funded

      t.timestamps null: false
    end
  end
end
