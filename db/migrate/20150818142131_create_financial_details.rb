class CreateFinancialDetails < ActiveRecord::Migration
  def change
    create_table :financial_details do |t|
      t.string :account_number
      t.string :branch_number
      t.references :address, index: true, foreign_key: true
      t.references :financial_institution, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
