Given /I am signed in as an? (.*)/ do |user_type|
  # todo: add more user types in the future
  case user_type
    when /distributor/i
      user_type = Distributor
    when /office manager/i
      user_type = OfficeManager
    when /office admin/i
      user_type = OfficeAdmin
    when /teamlead/i
      user_type = TeamLead
    when /recruiter/i
      user_type = Recruiter
    when /agent/i
      user_type = Agent
    else
      raise 'User type doesn\'t match allowed types'
  end

  if IndependentContractor::USER_SUBTYPE_CLASSES.member?(user_type)
    if user_type == Distributor
      @current_user = Distributor.joins(:distributorships).group('distributors.id')
                        .having('count(distributorships.id) = 1').sample
                        .independent_contractor.user
    else
      @current_user = user_type.all.sample.independent_contractor.user
    end
  end

  visit '/'
  fill_in('user_email', with: @current_user.email)
  fill_in('user_password', with: 'password')
  click_button('btnSignin')
  expect(page).to have_selector('body > #wrapper')
end
