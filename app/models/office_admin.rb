class OfficeAdmin < IcSubtype
  self.table_name = 'office_admins'
  has_one :independent_contractor
end
