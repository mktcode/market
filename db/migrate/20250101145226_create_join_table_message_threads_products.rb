class CreateJoinTableMessageThreadsProducts < ActiveRecord::Migration[8.0]
  def change
    create_join_table :message_threads, :products do |t|
      # t.index [:message_thread_id, :product_id]
      # t.index [:product_id, :message_thread_id]
    end
  end
end
