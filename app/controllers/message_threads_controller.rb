class MessageThreadsController < ApplicationController
  def index
    @incoming_message_threads = Current.user.incoming_message_threads
    @outgoing_message_threads = Current.user.outgoing_message_threads
  end

  def show
    @message_thread = MessageThread.find(params[:id]).tap do |thread|
      raise ActiveRecord::RecordNotFound unless thread.creator == Current.user || thread.recipient == Current.user
    end

    @message_thread.mark_as_read
  end

  def create_with_message_and_product
    product = Product.find(params[:product_id])
    recipient = product.user
    message_thread = MessageThread.create!(creator: Current.user, recipient: recipient)
    message_thread.messages.create!(sender: Current.user, content: params[:content])
    message_thread.products << product
    redirect_to message_thread_path(message_thread)
  end
end
