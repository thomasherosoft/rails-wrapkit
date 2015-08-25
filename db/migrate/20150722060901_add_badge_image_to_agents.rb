class AddBadgeImageToAgents < ActiveRecord::Migration
  def up
    add_attachment :agents, :badge_image
  end

  def down
    remove_attachment :agents, :badge_image
  end
end
