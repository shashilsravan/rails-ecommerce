class CartController < ApplicationController
  before_action :user_logged_in

  def index
    @items = Cart.all.where("user_id LIKE :user_id", user_id: current_user.id)
  end

  def create
    @quantity = params[:quantity]
    @user_id = params[:user_id]
    @product_id = params[:product_id]
    
    Cart.create(user_id: @user_id, product_id: @product_id, quantity: @quantity)
  end

  def destroy
    cart = Cart.find(params[:cart_id])
    cart.destroy
    flash[:success] = "Removed from cart successfully"
    redirect_to cart_path
  end

  def update
    @quantity = params[:quantity]
    @user_id = params[:user_id]
    @product_id = params[:product_id]
    
    cartItem = Cart.find_by(user_id: @user_id, product_id: @product_id)
    cartItem.update(user_id: @user_id, product_id: @product_id, quantity: @quantity)
  end

  private
    def user_logged_in
      if current_user.nil?
          redirect_to root_path
      end
    end

end
