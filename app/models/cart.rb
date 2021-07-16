class Cart < ApplicationRecord
    scope :current_user, ->(id) { where(user_id: id)}
    belongs_to :user
    belongs_to :product

    def self.current_user_cart_items(id)
        return Cart.current_user(id)
    end

    def self.calculateTotal(id)
        total = 0
        for each in Cart.current_user(id) do
           total += (each.product.price * each.quantity)
        end
        return total
    end

    def self.getProducts(id)
        result = []
        for each in Cart.current_user(id) do
            result.append({
                id: each.product.id,
                title: each.product.title,
                price: each.product.price,
                quantity: each.quantity
            })
        end
        return result
    end
end
