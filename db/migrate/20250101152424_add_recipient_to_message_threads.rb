class AddRecipientToMessageThreads < ActiveRecord::Migration[8.0]
  def change
    add_reference :message_threads, :recipient, null: false, foreign_key: { to_table: :users }
  end
end
