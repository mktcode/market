class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :products, dependent: :destroy
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 100, 100 ]
  end
  has_one_attached :header do |attachable|
    attachable.variant :big, resize_to_fill: [ 1920, 500 ]
  end
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def to_param
    name
  end
end
