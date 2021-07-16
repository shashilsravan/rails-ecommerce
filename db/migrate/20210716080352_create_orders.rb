class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :order_data
      t.string :deliver_address
      t.boolean :payment
      t.datetime :payed_at
      t.boolean :delivered
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
