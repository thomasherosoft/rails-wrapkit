class AddXorConstraintToUser < ActiveRecord::Migration
  def up
    conditions = []
    User::USER_SUBTYPES.each do |subtype|
      conditions.push("(#{subtype}_id IS NOT NULL)::integer")
    end

    execute "ALTER TABLE users ADD CONSTRAINT
               subtype_xor_check CHECK (#{conditions.join(' + ')} = 1)"
  end

  def down
    execute 'ALTER TABLE users DROP CONSTRAINT subtype_xor_check'
  end
end
