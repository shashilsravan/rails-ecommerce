module ProductsHelper
    def check_quantity(user_id ,product_id)
        cart = Cart.find_by(user_id: user_id, product_id: product_id)
        return cart.quantity
    end
end
