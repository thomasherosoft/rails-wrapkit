class ProductProgramPrice < ActiveRecord::Base
  include ModelHelpers
  belongs_to :product
  belongs_to :program

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
      product_id: object_data["ProductId"],
      program_id: object_data["ProgramId"],
      price: object_data["Price"],
      free_days: object_data["FreeDays"]
    }
  end
end
