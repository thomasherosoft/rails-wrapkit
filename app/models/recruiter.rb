class Recruiter < IcSubtype
  self.table_name = 'recruiters'
  has_one :independent_contractor
end
