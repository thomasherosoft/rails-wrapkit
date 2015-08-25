class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :initial_lead_booker, null: false
      t.string :initial_preinspector, null: false
      t.string :primary_first_name, null: false
      t.string :primary_last_name, null: false
      t.string :secondary_first_name, null: true
      t.string :secondary_last_name, null: true
      t.string :security_question, null: true
      t.string :security_answer, null: true
      t.string :phone_mobile, null: true
      t.string :fi_institution, null: true
      t.string :fi_institution_num, null: true
      t.string :fi_branch_num, null: true
      t.string :fi_account_num, null: true
      t.string :void_image_content_type, null: true
      t.string :void_image_file_name, null: true
      t.integer :void_image_file_size, null: true
      t.datetime :void_image_updated_at, null: true
      t.string :oba_ref_num	, null: true
      t.string :enbridge_num, null: true
      t.timestamps null: false
    end
  end
end
