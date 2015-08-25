class AddTeamLeadReferenceToAgents < ActiveRecord::Migration
  def change
    change_table :agents do |t|
      t.references :team_lead, null: false
    end

    add_foreign_key :agents, :team_leads
  end
end
