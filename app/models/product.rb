class Product < ApplicationRecord
  belongs_to :user
  has_many :materials, dependent: :destroy
  has_and_belongs_to_many :message_threads
  accepts_nested_attributes_for :materials, allow_destroy: true, reject_if: lambda { |attributes| attributes["name"].blank? }
  has_rich_text :body
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_fill: [ 350, 350 ]
    attachable.variant :big, resize_to_limit: [ 1000, 1000 ]
  end

  def ordered_images
    images.sort_by(&:id)
  end
end
