Feature: Get a list of all the Independent Contractors (IC)
  In order to get a list of all the ICs
  As any user of the system
  I want to visit the IC page

  @javascript
  Scenario: Viewing as a distributor
    Given There exist ICs that belong to various distributorships
      And I am signed in as a distributor
     When I visit the IC page
     Then I should see a full list of all ICs that belong to my distributorships

  @javascript
  Scenario: Viewing as an office manager
    Given There exist ICs that belong to various distributorships
      And I am signed in as an office manager
     When I visit the IC page
     Then I should only see the office's recruiters and office admins

  @javascript
  Scenario: Viewing as an office admin
    Given There exist ICs that belong to various distributorships
      And I am signed in as an office admin
     When I visit the IC page
     Then I should only see the office's team leads and agents

  @javascript
  Scenario: Viewing as a Recruiter
    Given There exist ICs that belong to various distributorships
      And I am signed in as a Recruiter
     When I visit the IC page
     Then I should only see the office's team leads, agents and office admins

  @javascript
  Scenario: Viewing as a team lead
    Given There exist ICs that belong to various distributorships
      And I am signed in as a teamlead
     When I visit the IC page
     Then I should only see the agents that belong to me

  Scenario: Viewing as an agent
    Given There exist ICs that belong to various distributorships
      And I am signed in as an agent
     Then I should not be able to visit the IC page
