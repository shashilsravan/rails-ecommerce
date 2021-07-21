class OrderController < ApplicationController
    before_action :set_order, only: [:show, :edit, :payment, :delivered]
    before_action :check_loggedin

    def all
        if current_user.admin?
            @pagy, @orders = pagy(Order.all.order(created_at: :desc), items: 6)
        else
            redirect_to orders_path
        end
    end

    def index
        @orders = Order.where(user_id: current_user.id).order(created_at: :desc)
    end

    def create
        user_id = current_user.id
        order_data = Cart.getProducts(user_id)

        # checking product in stock
        for each in order_data do
            product_stock = Product.find(each[:id]).stock
            if product_stock < each[:quantity]
                flash[:now] = "Items in your cart are not in our stock"
                redirect_to cart_path
            end
        end

        order = Order.new(user_id: user_id, 
            order_data: order_data,
            deliver_address: Address.getUserAddress(user_id),
            total_price: Cart.calculateTotal(user_id).to_s)
    
        if order.save
            for each in order_data do
                product = Product.find(each[:id])
                product.update(stock: product.stock - each[:quantity])
            end
        end

        Cart.where(user_id: user_id).destroy_all
        redirect_to order_details_path(order.id)
    end

    def show
        respond_to do |format|
            format.html
            format.pdf do
                render pdf: "Order #{@order.id}", template: "order/invoice.html.erb"
            end
        end
    end

    def payment
        if @order.user_id != current_user.id
            flash[:now] = "Action prohbitied"
            redirect_to root_path
        end
        @order.payment = true
        @order.payed_at = Time.now()
        @order.save
        redirect_to order_details_path(@order)
    end

    def delivered
        if not current_user.admin?
            flash[:now] = "Action prohbitied"
            redirect_to root_path
        end
        @order.delivered = true
        @order.delivered_at = Time.now()
        @order.save
        redirect_to order_details_path(@order)
    end

    private
        def set_order
            @order = Order.find(params[:id])
            if @order.user_id != current_user.id and not current_user.admin?
                flash[:now] = "Action prohbitied"
                redirect_to orders_path
            end
        end

        def check_loggedin
            unless user_signed_in?
                flash[:now] = "Please login to see your orders"
                redirect_to root_path
            end
        end
end
