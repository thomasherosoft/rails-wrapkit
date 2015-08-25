class Product < ActiveRecord::Base
  include ModelHelpers
  has_many :customers, through: :customer_product
  has_many :customer_product
  has_and_belongs_to_many :programs, through: :product_program_prices
  has_and_belongs_to_many :agreements

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
      name: object_data["Product"],
      description: object_data["Description"],
      duration: object_data["Duration"],
      allow_sales: object_data["AllowSales"],
      # product_type_id: object_data[""],
      # product_sub_type_id: object_data["ProductSubType"],
      active: object_data["Status"] == "Active" ? true : false
    }
  end

end
