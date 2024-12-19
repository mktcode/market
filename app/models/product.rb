class Product < ApplicationRecord
  belongs_to :user
  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :materials, allow_destroy: true, reject_if: :all_blank
  has_rich_text :body
  has_many_attached :images
end
