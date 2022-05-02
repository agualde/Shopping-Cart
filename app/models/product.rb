class Product < ApplicationRecord
    has_many :order_items
    validates :name, :code, :img_url, :price, presence: true
    validates :code, uniqueness: true

    include PgSearch::Model
    pg_search_scope :global_search,
    against: [ :name, :code ],
    associated_against: {
    },
      using: {
        tsearch: { prefix: true }
      }
      
end
