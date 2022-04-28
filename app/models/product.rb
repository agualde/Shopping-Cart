class Product < ApplicationRecord
    has_many :order_items

    validates :name, :code, :price, presence: true
end
