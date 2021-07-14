class Cart < ApplicationRecord
    belongs_to :user
    belongs_to :product

    def self.current_user_cart_items(id)
        return Cart.all.where("user_id LIKE :user_id", user_id: id)
    end
end
