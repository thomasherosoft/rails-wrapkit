And /There exist ICs that belong to various distributorships/ do
  2.times do
    FactoryGirl.create(:distributorship_with_ics)
  end
end

When /I visit the IC page/ do
  visit independent_contractors_path
  expect(page).to have_selector('.independent_contractors.index')
  wait_for_ajax
end

# assuming already on IC index page
def verify_ics_are_visible(ic_agent_numbers)
  loop do
    dom_agent_numbers = page.all('td.agent-number').map{|x| x.text.to_i}

    # This makes sure we're not seeing more than
    # we're supposed to be seeing
    expect((dom_agent_numbers - ic_agent_numbers).length).to eq(0)

    agents_left = ic_agent_numbers.length
    ic_agent_numbers -= dom_agent_numbers
    expect(ic_agent_numbers.length).to eq(agents_left - dom_agent_numbers.length)

    break if page.evaluate_script("$('li.next.disabled').length > 0")

    find('li.next>a').click
    wait_for_ajax
  end
  expect(ic_agent_numbers.length).to eq(0)
end

# Viewing as a distributor
Then /I should see a full list of all ICs that belong to my distributorships/ do
  verify_ics_are_visible(
    IndependentContractor
      .where(office: @current_user.get_absolute_subtype
                       .distributorships.joins(:offices)
                       .select('offices.id').distinct.pluck('offices.id'))
      .where.not(id: @current_user.subtype.id).pluck(:agent_number))
end

# Viewing as an office manager
Then /I should only see the office's recruiters and office admins/ do
  verify_ics_are_visible(
    IndependentContractor
      .where(office: @current_user.subtype.office)
      .where('recruiter_id is not null OR office_admin_id is not null')
      .pluck(:agent_number)
  )
end

# Viewing as an office admin
Then /I should only see the office's team leads and agents/ do
  verify_ics_are_visible(
    IndependentContractor
      .where(office: @current_user.subtype.office)
      .where('team_lead_id is not null OR agent_id is not null')
      .pluck(:agent_number)
  )
end

# Viewing as a recruiter
Then /I should only see the office's team leads, agents and office admins/ do
  verify_ics_are_visible(
    IndependentContractor
      .where(office: @current_user.subtype.office)
      .where('team_lead_id is not null OR agent_id is not null OR office_admin_id is not null')
      .pluck(:agent_number)
  )
end

# Viewing as a team lead
Then /I should only see the agents that belong to me/ do
  verify_ics_are_visible(
    IndependentContractor
      .where(agent_id: @current_user.get_absolute_subtype.agents.pluck(:id))
      .pluck(:agent_number)
  )
end

# Viewing as an agent
Then /I should not be able to visit the IC page/ do
  expect(page).to_not have_selector('ic-page-nav-link')
  visit independent_contractors_path
  expect(page.status_code).to be(404)
end
