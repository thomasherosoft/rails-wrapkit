class OfficeManager < IcSubtype
  self.table_name = 'office_managers'
  has_one :independent_contractor
end
