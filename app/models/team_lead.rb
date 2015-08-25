class TeamLead < IcSubtype
  self.table_name = 'team_leads'
  has_one :independent_contractor
  has_many :agents
end
