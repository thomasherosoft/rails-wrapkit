class Api::V1::BaseController < Api::BaseController
  before_action :authenticate_user!

  def auth_test
    render json: {testing: 'If you can see this, you are properly authenticated!'}
  end
end
