class AddUseServiceAddressToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :use_service_address, :boolean
  end
end
