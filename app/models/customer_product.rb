class CustomerProduct < ActiveRecord::Base

  include ModelHelpers

  belongs_to :customer
  # belongs_to :application
  belongs_to :program
  belongs_to :product
  enum status: [:incompleted, :pending, :inpending, :pischeduled, :picompleted, :pipending, :incancelled, :picancelled, :inscheduled]
  enum type: [:lease, :someother]

  def self.create_from_api(object_data)
    if exists?(object_data["Id"])
      update(object_data["Id"], build_data(object_data))
    else
      create!(build_data(object_data))
    end
  end

  def self.build_data(object_data)
    {
      customer_id: object_data["CustomerId"],
      # application_id: self.generate_application_id(object_data["ApplicationNumber"]),
      application_number: object_data["ApplicationNumber"],
      status: object_data["CustomerProductStatus"].downcase,
      program_id: object_data["ProgramId"],
      product_id: object_data["ProductId"],
      price: object_data["Price"],
      hst: object_data["Hst"] == "Yes" ? true : false,
      free: object_data["Free"] == "Yes" ? true : false,
      serial_number: object_data["SerialNo"],
      model_number: object_data["ModelNo"],
      cp_type: object_data["Type"].downcase,
      coil_serial_number: object_data["CoilSerialNo"],
      coil_model_number: object_data["CoilModelNo"],
      purchase_date: process_remote_date(object_data["PurchaseDate"]),
      funded: object_data["funded"]
    }
  end

private

  def self.generate_application_id(app_id)
    Application.find_or_create_by!(id: app_id)
  end
end
