class Agent < IcSubtype
  self.table_name = 'agents'
  include ModelHelpers
  has_one :independent_contractor
  belongs_to :team_lead

  attr_accessor :full_name

  # scope :general, -> { select(:id, :active, :agent_number, :first_name, :last_name, :agent_number, :distributor_name, :designation, :email) }

  has_attached_file :badge_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "missing.svg"
  # validates_attachment_content_type :badge_image, :content_type => /\Aimage\/.*\Z/

  def self.create_from_api(agent)
    if Agent.exists?(agent["AgentId"])
      Agent.update(agent["AgentId"], build_agent_data(agent))
    else
      Agent.create(build_agent_data(agent))
    end
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def self.build_agent_data(agent)
    {
      id: agent["AgentId"],
      agent_number: agent["AgentNumber"],
      contract_company: agent["ContractCompany"],
      first_name: agent["FirstName"],
      last_name: agent["LastName"],
      mobile: agent["Mobile"],
      email: agent["Email"],
      address: agent["Address"],
      city: agent["City"],
      postal_code: agent["PostalCode"],
      province: agent["Province"],
      country: agent["Country"],
      card_number: agent["CardNumber"],
      sin_number: agent["SinNumber"],
      gst_number: agent["GstNumber"],
      bin_number: agent["BinNumber"],
      pre_inspector: agent["PreInspector"].downcase != 'no',
      ic_signed: agent["IcSigned"],
      designation: agent["Designation"],
      payment_method: agent["PaymentMethod"],
      distributor_name: agent["DistributorName"],
      active: true
    }
  end
end
