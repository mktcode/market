class ApplicationController < ActionController::Base
  include Authentication
  before_action :load_session_if_available
  before_action :unread_messages_count
  allow_browser versions: :modern

  private

  def load_session_if_available
    authenticated?
  end

  def unread_messages_count
    return 0 unless Current.user
    Current.unread_messages_count = 1
  end
end
