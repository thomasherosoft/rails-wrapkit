class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_unauthorized

  private
  def user_unauthorized
    raise ActionController::RoutingError.new('Not Found')
  end
end
