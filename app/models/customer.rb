class Customer < ActiveRecord::Base

  include ModelHelpers
  has_many :addresses
  delegate :billing_address, :mailing_address, :service_address, :financial_address, to: :address

  belongs_to :address_service, class_name: "Address"
  belongs_to :address_mailing, class_name: "Address"
  belongs_to :address_billing, class_name: "Address"

  has_many :products, through: :customer_product
  has_many :customer_product
  has_many :product_details, through: :customer_product,
           class_name: "CustomerProduct",
           source: :product,
           join_table: :product

# Unknown key: :select. Valid keys are: :class_name, :class, :foreign_key, :validate, :autosave, :table_name, :before_add, :after_add, :before_remove, :after_remove, :extend, :primary_key, :dependent, :as, :through, :source, :source_type, :inverse_of, :counter_cache, :join_table, :foreign_type

  scope :general, -> { select(:id, :first_name, :last_name, :service_phone, :service_street_number, :service_address, :service_city, :service_province) }

  def full_name
    [first_name, last_name].join(' ')
  end

  def phone_number
    if service_phone
      service_phone
    elsif service_mobile
      service_mobile
    elsif mailing_phone
      mailing_phone
    else
      mailing_mobile
    end
  end

  def address
    street_address = [service_street_number, service_address].join(' ')
    [street_address, city_province_country].join(', ')
  end

  def city_province_country
    [service_city, service_province].join(', ')
  end

  def self.create_from_api(customer)
    if Customer.exists?(customer["CustomerId"])
      Customer.update(customer["CustomerId"], build_customer_data(customer))
    else
      Customer.create!(build_customer_data(customer))
    end
  end

  def self.build_customer_data(customer)
    {
      id: customer["CustomerId"],
      lead_booker: customer["Leadbooker"],
      code: customer["Code"],
      first_name: customer["FirstName"],
      last_name: customer["LastName"],
      service_street_number: customer["ServiceStreetNumber"],
      service_address: customer["ServiceAddress"],
      service_address2: customer["ServiceMiscAddress"],
      service_city: customer["ServiceCity"],
      service_province: customer["ServiceProvince"],
      service_country: customer["ServiceCountry"],
      service_phone: customer["ServicePhone"],
      service_mobile: customer["ServiceMobile"],
      service_email: customer["ServiceEmail"],
      territory: customer["Territory"],
      mop: customer["MOP"],
      enbridge_account_number: customer["EnbridgeAccountNumber"],
      oba_reference_number: customer["OBAReferenceNumber"],
      financial_institution: customer["FinancialInstitution"],
      fi_branch: customer["FIBranch"],
      fi_address: customer["FIAddress"],
      fi_city: customer["FICity"],
      fi_postal_code: customer["FIPostalCode"],
      fi_account_number: customer["FIAccountNumber"],
      mailing_street_number: customer["MailingStreetNumber"],
      mailing_address: customer["MailingAddress"],
      mailing_address2: customer["MailingMiscAddress"],
      mailing_city: customer["MailingCity"],
      mailing_province: customer["MailingProvince"],
      mailing_country: customer["MailingCountry"],
      mailing_phone: customer["MailingPhone"],
      mailing_mobile: customer["MailingMobile"],
      mailing_email: customer["MailingEmail"],
      created_at: process_remote_date(customer["CustomerCreated"])
    }
  end

end
