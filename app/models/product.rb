class Product < ApplicationRecord
    has_many :order_items, dependent: :destroy
    belongs_to :category, optional: true
    validates :name, :code, :img_url, :price, presence: true
    validates :code, uniqueness: true

    include PgSearch::Model
    pg_search_scope :global_search,
    against: [ :name, :code, :tags ],
    associated_against: { 
      category: [:name]
    },
      using: {
        tsearch: { prefix: true }
      }
      
end
