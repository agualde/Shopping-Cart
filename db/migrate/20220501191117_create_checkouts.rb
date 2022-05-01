class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|
      t.string :state, default: 'pending'
      t.decimal :amount
      t.string :checkout_session_id
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
