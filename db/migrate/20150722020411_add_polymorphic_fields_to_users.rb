class AddPolymorphicFieldsToUsers < ActiveRecord::Migration
  def change
    User::USER_SUBTYPES.each do |subtype|
      change_table :users do |t|
          t.references subtype
      end
    end
  end
end
