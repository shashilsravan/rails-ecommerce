class AddIndexToCart < ActiveRecord::Migration[6.1]
  def change
    add_index :carts, :user_id
    add_index :carts, :product_id
    add_index :carts, [:user_id, :product_id], unique:true
  end
end
