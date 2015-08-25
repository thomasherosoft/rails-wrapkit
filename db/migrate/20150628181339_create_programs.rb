class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.string :billing_method, null: false
      t.integer :program_name, null: false
      t.integer :agreement_num, null: false
      t.string :lead_booker, null: false
      t.string :preinspector, null: false
      t.string :method_of_payment, null: false
      t.datetime :agreement_date, null: false
      t.boolean :active, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :country, null: false
      t.string :state_province, null: false
      t.integer :territory, null: true
      t.string :frequency, null: false
      t.text :tandc_front, null: true
      t.text :tandc_back, null: true

      t.timestamps null: false
    end
  end
end
