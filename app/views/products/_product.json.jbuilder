json.extract! product, :id, :name, :code, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
