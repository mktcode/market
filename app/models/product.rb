class Product < ApplicationRecord
  belongs_to :user
  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :materials, allow_destroy: true, reject_if: lambda { |attributes| attributes["name"].blank? }
  has_rich_text :body
  has_many_attached :images

  def ordered_images
    images.sort_by(&:id)
  end
end
