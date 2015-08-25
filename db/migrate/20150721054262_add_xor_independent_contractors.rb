class AddXorIndependentContractors < ActiveRecord::Migration
  def up
    conditions = []
    IndependentContractor::USER_SUBTYPES.each do |ic_type|
      conditions.push("(#{ic_type}_id IS NOT NULL)::integer")
    end

    execute "ALTER TABLE independent_contractors ADD CONSTRAINT
               subtype_xor_check CHECK (#{conditions.join(' + ')} = 1)"
  end

  def down
    execute 'ALTER TABLE independent_contractors DROP CONSTRAINT subtype_xor_check'
  end
end
