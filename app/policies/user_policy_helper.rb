module UserPolicyHelper
  def all_user_types
    User::USER_SUBTYPE_CLASSES + IndependentContractor::USER_SUBTYPE_CLASSES
  end
  def all_users_except(user_type)
    (all_user_types - [user_type])
  end
end
