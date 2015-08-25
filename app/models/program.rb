class Program < ActiveRecord::Base
  include ModelHelpers
  has_and_belongs_to_many :products, through: :product_program_prices

  enum billing_type: [ :monthly, :quarterly, :yearly ]


  def self.create_from_api(object_data)
    if exists?(object_data["Id"])
      update(object_data["Id"], build_data(object_data))
    else
      create!(build_data(object_data))
    end
  end

  def self.build_data(object_data)
   {
      id: object_data["Id"],
      name: object_data["Name"],
      description: object_data["Description"],
      start_date: process_remote_date(object_data["StartDate"]),
      end_date: process_remote_date(object_data["EndDate"]),
      billing_type: object_data["BillingType"].downcase,
      active: object_data["Status"] == "Active" ? true : false
    }
  end
end
