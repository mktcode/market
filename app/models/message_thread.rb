class MessageThread < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :products

  def mark_as_read
    messages.where(read_at: nil).each do |message|
      message.update!(read_at: Time.current) if recipient == Current.user
    end
  end
end
