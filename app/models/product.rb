class Product < ApplicationRecord
  has_rich_text :body
  has_many_attached :images
end
