json.extract! product, :id, :title, :body, :created_at, :updated_at
json.url product_url(product, format: :json)
