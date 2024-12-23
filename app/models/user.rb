class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 100, 100 ]
  end
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def to_param
    name
  end
end
