class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         password_length: 6..128
  include DeviseTokenAuth::Concerns::User

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save { email.downcase! }

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates_presence_of :first_name, :last_name, :username, :password, :password_confirmation, :country, :state_province, :city, :postal_zip, :street_number, :street_name, :street_type

  USER_SUBTYPES = %i(
    independent_contractor
    employee
  )

  USER_SUBTYPES.each do |type|
    belongs_to type, dependent: :destroy
  end

  USER_SUBTYPE_CLASSES = USER_SUBTYPES.map{ |type|
    Object.const_get(type.to_s.camelcase)
  }

  include HasUserSubtypes

  def get_absolute_subtype
    retval = self
    loop do
      break if !retval.respond_to? :subtype
      temp = retval.subtype
      retval = temp
    end
    retval
  end

  def self.create_dummy_user_of_type(wanted_klass_name, options = {})
    def self.create_users_recurs(klass_name, wanted_klass_name, ancestry_array)
      klass = Object.const_get(klass_name.to_s.camelcase)

      if defined?(klass::USER_SUBTYPES) && !klass::USER_SUBTYPES.member?(klass_name)
        klass::USER_SUBTYPES.each do |subtype_class|
          if create_users_recurs(subtype_class, wanted_klass_name, ancestry_array)
            ancestry_array.push(klass_name)
          end
        end
      else
        if klass_name == wanted_klass_name
          ancestry_array.push(klass_name)
          return true
        end
      end
    end

    ancestry_array = []
    create_users_recurs(:user, wanted_klass_name, ancestry_array)

    # e.g. [:agent, :independent_contract, :user]
    if ancestry_array.member?(:independent_contractor) && !options.has_key?(:office)
      raise 'Can\'t create IC-type user without specifying an office'
    end

    child = nil
    ancestry_array.each do |type|
      obj = FactoryGirl.build(type)
      obj.email = options[:email] if obj.class == User && options[:email]
      obj.password_confirmation = obj.password = options[:password] if obj.class == User && options[:password]

      if type == :agent
        obj.team_lead = options[:team_lead]
      end

      if type == :independent_contractor
        obj.office = options[:office]
      end

      if type == :distributor
        obj.distributorships << options[:distributorship]
      end

      if child
        obj.subtype = child
      end

      obj.save!
      child = obj
    end

    return child
  end
end

