module HttpAuthConcern
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  extend ActiveSupport::Concern
  
  included do
    before_action :authenticate_account
  end

  def authenticate_account
    authenticate_or_request_with_http_basic do |username, auth_id|
      @current_account = Account.find_by(username: username, auth_id: auth_id)
      !@current_account.nil?
    end
  end
end
