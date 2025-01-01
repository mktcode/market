class RegistrationMailer < ApplicationMailer
  def confirmation(user)
    @user = user
    @confirmation_url = confirm_registration_url(token: @user.email_confirmation_token)
    mail(to: @user.email_address, subject: "Bestätige deine E-Mail-Adresse")
  end
end
