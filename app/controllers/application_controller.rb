class ApplicationController < ActionController::Base
  include Authentication
  before_action :load_session_if_available
  allow_browser versions: :modern

  private

  def load_session_if_available
    authenticated?
  end
end
