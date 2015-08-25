class IndependentContractor < UserSubtype
  include HasUserSubtypes

  self.table_name = 'independent_contractors'
  has_one :user
  accepts_nested_attributes_for :user

  USER_SUBTYPES = %i(
    distributor
    office_manager
    office_admin
    recruiter
    team_lead
    agent
  )

  USER_SUBTYPES_FOR_SELECT = [
    {"name" => "Distributor"},
    {"name" => "Office Manager"},
    {"name" => "Office Admin"},
    {"name" => "Recruiter"},
    {"name" => "Team Lead"},
    {"name"=> "Agent"},
  ]

  USER_SUBTYPES.each do |type|
    belongs_to type, dependent: :destroy
  end

  USER_SUBTYPE_CLASSES = USER_SUBTYPES.map{ |type|
    Object.const_get(type.to_s.camelcase)
  }

  belongs_to :office

  validates_presence_of :ic_code
end
