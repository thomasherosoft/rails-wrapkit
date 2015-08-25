class ChangesToCustomer < ActiveRecord::Migration
  def up
    add_reference :customers, :financial_details
    remove_column :customers, :fi_institution
    remove_column :customers, :fi_institution_num
    remove_column :customers, :fi_branch_num
    remove_column :customers, :fi_account_num
    rename_column :customers, :initial_preinspector, :initial_closer
    add_column :customers, :address_service_id, :integer
    add_column :customers, :address_mailing_id, :integer
    add_column :customers, :address_billing_id, :integer
  end

  def down
    remove_reference :customers, :financial_details
    add_column :customers, :fi_institution, :string
    add_column :customers, :fi_institution_num, :string
    add_column :customers, :fi_branch_num, :string
    add_column :customers, :fi_account_num, :string
    rename_column :customers, :initial_closer, :initial_preinspector
    remove_column :customers, :address_service_id
    remove_column :customers, :address_mailing_id
    remove_column :customers, :address_billing_id
  end

end
