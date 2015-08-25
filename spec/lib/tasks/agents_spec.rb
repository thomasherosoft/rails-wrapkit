require 'rails_helper'

describe "agents"  do

  include_context "rake"

  describe "#migrate" do
    it "imports agents from remote api" do
      # TODO: Create agents properly when schema is ready
      # expect { rake['agents:migrate'].invoke(1,3) }.to change { Agent.count }.by(3)
    end
  end

end
