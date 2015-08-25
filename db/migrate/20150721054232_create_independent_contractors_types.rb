class CreateIndependentContractorsTypes < ActiveRecord::Migration
  def change
    IndependentContractor::USER_SUBTYPES.each do |ic_type|
      create_table ic_type.to_s.pluralize do |t|
        t.timestamps null: false
      end
    end

    IndependentContractor::USER_SUBTYPES.each do |ic_type|
      change_table :independent_contractors do |t|
        t.references ic_type
      end
    end
  end
end
