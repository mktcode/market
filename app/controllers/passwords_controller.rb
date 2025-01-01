class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: "Link zum Zurücksetzen des Passworts wurde versendet (falls ein Benutzer mit dieser E-Mail-Adresse existiert)."
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "Passwort wurde erfolgreich geändert."
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwort und Passwortbestätigung stimmen nicht überein."
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Der Link zum Zurücksetzen des Passworts ist ungültig oder abgelaufen."
    end
end
