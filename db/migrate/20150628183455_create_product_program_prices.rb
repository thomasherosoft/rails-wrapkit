class CreateProductProgramPrices < ActiveRecord::Migration
  def change
    create_table :product_program_prices do |t|
      t.references :product, index: true, foreign_key: true
      t.references :program, index: true, foreign_key: true
      t.float :price

      t.timestamps null: false
    end

    add_index :product_program_prices, [:product_id, :program_id]
  end
end
