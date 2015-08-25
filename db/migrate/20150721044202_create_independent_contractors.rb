class CreateIndependentContractors < ActiveRecord::Migration
  def change
    create_table :independent_contractors do |t|
      t.integer :agent_number, null: false
      t.string :business_num, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.string :card_number, null: false
      t.string :gst_number, null: true
      t.string :ic_code, null: false
      t.string :payment_method, null: false
      t.string :phone_business, null: true
      t.string :phone_home, null: false
      t.string :phone_mobile, null: false
      t.string :postal_zip, null: false
      t.string :sin, null: true
      t.string :state_province, null: false
      t.string :street_name, null: false
      t.string :street_number, null: false
      t.string :street_type, nulL: false
      t.string :unit_num, null: false
      t.boolean :preinspector, null: false
      t.boolean :lead_booker, null: false
      t.boolean :ic_signed, null: false
      t.timestamps null: false
    end

    add_index :independent_contractors, :agent_number, unique: true
  end
end
