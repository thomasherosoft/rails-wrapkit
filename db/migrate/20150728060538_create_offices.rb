class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :name, null: false
      t.string :street_num, null: true
      t.string :street_name, null: true
      t.string :street_type, null: true
      t.string :unit_num, null: true
      t.string :postal_zip, null: true
      t.string :city, null: true
      t.string :state_province, null: true
      t.string :country, null: true
      t.references :distributorship, index: true
      t.timestamps null: false
    end

    change_table :independent_contractors do |t|
      t.references :office, index: true
    end
  end
end
