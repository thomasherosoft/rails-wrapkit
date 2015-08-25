class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :city, null: false
      t.string :employee_type, null: true
      t.string :country, null: false
      t.string :designation, null: true
      t.string :phone_home, null: false
      t.string :phone_mobile, null: true
      t.string :postal_zip, null: false
      t.string :sin, null: true
      t.string :state_province, null: false
      t.string :street_name, null: false
      t.string :street_number, null: false
      t.string :street_type, null: true
      t.timestamps null: false
    end
  end
end
