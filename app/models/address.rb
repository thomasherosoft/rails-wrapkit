class Address < ActiveRecord::Base
  belongs_to :customer
  self.inheritance_column = :address_type

  ADDRESS_TYPES = %i(
    billing
    financial
    service
    mailing
  )

  ADDRESS_TYPES.each do |type|
    scope type, -> { where(address_type: type.to_s) }
  end
end

class BillingAddress < Address
end

class FinancialAddress < Address
end

class ServiceAddress < Address
end

class MailingAddress < Address
end
