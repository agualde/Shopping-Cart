class AddOrderToCheckout < ActiveRecord::Migration[6.1]
  def change
    add_reference :checkouts, :orders, foreign_key: true
  end
end
