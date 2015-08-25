class IndependentContractorPolicy < ApplicationPolicy
  include UserPolicyHelper

  def index?
    all_users_except(Agent).member? user.subtype.class
  end
end
