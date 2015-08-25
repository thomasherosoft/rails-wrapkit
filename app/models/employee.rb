class Employee < UserSubtype
  self.table_name = 'employees'
  has_one :user
end
