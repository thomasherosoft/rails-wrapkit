class Distributor < IcSubtype
  self.table_name = 'distributors'
  has_one :independent_contractor
  has_and_belongs_to_many :distributorships
end
