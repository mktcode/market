class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create confirm ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    email_confirmation_token = SecureRandom.urlsafe_base64(32)

    user = User.new(
      name: params[:name],
      email_address: params[:email_address],
      password_digest: BCrypt::Password.create(params[:password]),
      email_confirmation_token: email_confirmation_token
    )

    if user.save
      RegistrationMailer.confirmation(user).deliver_now
      redirect_to new_session_url, notice: "Registierung erfolgreich. Klicke bitte auf den Link in der E-Mail, die wir dir geschickt haben."
    else
      redirect_to new_registration_url, alert: user.errors.full_messages.to_sentence
    end
  end

  def confirm
    user = User.find_by(email_confirmation_token: params[:token])

    if user
      user.update!(email_confirmation_token: nil)
      start_new_session_for user
      redirect_to after_authentication_url, notice: "E-Mail-Adresse bestätigt. Herzlich willkommen!"
    else
      redirect_to new_session_url, alert: "Ungültiger Bestätigungslink."
    end
  end
end
