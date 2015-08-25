class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.integer :agreement_num, null: false
      t.string :lead_booker, null: false
      t.string :preinspector, null: false
      t.string :method_of_payment, null: false
      t.datetime :agreement_date, null: false
      t.timestamps null: false
    end

    create_table :agreements_products, id: false do |t|
      t.references :agreement, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
  end
end
