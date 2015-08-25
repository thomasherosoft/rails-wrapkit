class CreateFinancialInstitutions < ActiveRecord::Migration
  def change
    create_table :financial_institutions do |t|
      t.string :fi_name
      t.string :fi_number
      t.integer :fi_head_address, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
