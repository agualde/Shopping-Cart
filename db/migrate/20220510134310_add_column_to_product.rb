class AddColumnToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :description, :text
  end
end
