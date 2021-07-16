class CartController < ApplicationController
  before_action :user_logged_in
  before_action :cart_items_exists, only: [:checkout, :order]
  before_action :check_in_stock, only: [:order, :checkout]

  def index
    @items = Cart.where(user_id: current_user.id)
  end

  def create
    @quantity = params[:quantity]
    @product_id = params[:product_id]
    
    Cart.create(user_id: current_user.id, product_id: @product_id, quantity: @quantity)
  end

  def destroy
    cart = Cart.find(params[:cart_id])
    cart.destroy
    flash[:success] = "Removed from cart successfully"
    redirect_to cart_path
  end

  def destroyAll
    Cart.where(user_id: current_user.id).destroy_all
    render :partial => "emptycart"
  end

  def update
    @quantity = params[:quantity]
    @product_id = params[:product_id]
    
    cartItem = Cart.find_by(user_id: current_user.id, product_id: @product_id)
    cartItem.update(quantity: @quantity)
  end

  def checkout
    @items = Cart.where(user_id: current_user.id)
  end

  def order
    if current_user.address.nil?
      flash[:warning] = "Your address isn't stored, please try again"
      redirect_to root_path
    end
    @address = current_user.address
    @items = Cart.where(user_id: current_user.id)
  end

  private
    def user_logged_in
      if current_user.nil?
          redirect_to root_path
      end
    end

    def cart_items_exists
      if Cart.where(user_id: current_user.id).count < 1
          flash[:success] = "Your cart is empty to checkout"
          redirect_to root_path
      end
    end

    def check_in_stock
      cart = Cart.where(user_id: current_user.id)
      for each in cart do 
        if not each.product.has_stock?
          flash[:now] = "There are no stock items in your cart, remove them"
          redirect_to cart_path
        end
      end
    end
end
