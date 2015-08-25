class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :city, null: false
      t.string :country, null: false
      t.string :phone_home, null: false
      t.string :postal_zip, null: false
      t.string :state_province, null: false
      t.string :street_name, null: false
      t.string :street_number, null: false
      t.string :street_type, null: false
      t.string :unit_num, null: false
      t.integer :square_footage, null: true
      t.string :pre_existing_heating, null: true
      t.string :pre_existing_heating_age, null: true
      t.string :pre_existing_cooling, null: true
      t.string :pre_existing_cooling_age, null: true
      t.string :pre_existing_water, null: true
      t.string :pre_existing_water_age, null: true
      t.string :pre_existing_water_provider, null: true

      t.string :address_type, null: false
      t.references :customer, index: true

      t.timestamps null: false
    end
  end
end
