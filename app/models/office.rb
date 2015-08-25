class Office < ActiveRecord::Base
  belongs_to :distributorship
  has_many :independent_contractors
end
