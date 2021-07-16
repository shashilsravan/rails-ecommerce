class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :phone
      t.string :email
      t.string :zipcode
      t.text :location

      t.timestamps
    end
  end
end
