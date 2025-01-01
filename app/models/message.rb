class Message < ApplicationRecord
  belongs_to :message_thread
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
end
