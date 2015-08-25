class IcMenuPolicy < Struct.new(:user, :ic_menu)
  include UserPolicyHelper

  def any?
    all_users_except(Agent).member? user.get_absolute_subtype.class
  end

  def show?
    any?
  end

  def index?
    any?
  end
end
