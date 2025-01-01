class MessageMailer < ApplicationMailer
  def new_message
    @message_thread = params[:message_thread]
    @message = @message_thread.messages.last
    @sender = @message_thread.creator
    @recipient = @message_thread.recipient

    mail(to: @recipient.email_address, subject: "Du hast eine neue Nachricht")
  end
end
