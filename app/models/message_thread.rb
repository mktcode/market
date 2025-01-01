class MessageThread < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :products
end
