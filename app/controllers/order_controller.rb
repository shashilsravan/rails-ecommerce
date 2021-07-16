class OrderController < ApplicationController
    before_action :set_order, only: [:show, :edit]

    def create
        user_id = current_user.id
        order = Order.new(user_id: user_id, 
                order_data: Cart.getProducts(user_id),
                deliver_address: Address.getUserAddress(user_id),
                total_price: Cart.calculateTotal(user_id).to_s)
        order.save
        Cart.where(user_id: user_id).destroy_all
        redirect_to order_details_path(order.id)
    end

    def show
    end

    def payment
        id = params[:id]
        order = Order.find(id)
        if order.user_id != current_user.id
            flash[:now] = "Action prohbitied"
            redirect_to root_path
        end
        order.payment = true
        order.payed_at = Time.now()
        order.save
        redirect_to order_details_path(order)
    end

    private
        def set_order
            @order = Order.find(params[:id])
        end
end
