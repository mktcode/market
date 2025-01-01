class CreateMessageThreads < ActiveRecord::Migration[8.0]
  def change
    create_table :message_threads do |t|
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
