class AddBooleanToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :discounted, :boolean, default: false
  end
end
