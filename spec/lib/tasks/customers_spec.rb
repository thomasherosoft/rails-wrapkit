require 'rails_helper'

describe "customers"  do

  include_context "rake"

  describe "#migrate" do
    # it "imports customers from remote api" do
    #   expect { rake['customers:migrate'].invoke(1,3) }.to change { Customer.count }.by(3)
    # end
  end

end
