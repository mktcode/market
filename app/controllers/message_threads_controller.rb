class MessageThreadsController < ApplicationController
  def index
    @message_threads = Current.user.message_threads
  end

  def show
    @message_thread = Current.user.message_threads.find(params[:id])
    @message_thread.mark_as_read
  end
end
