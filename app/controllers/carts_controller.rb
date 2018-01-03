class CartsController < ApplicationController

  def show
    @cart = current_user.current_cart
  end

  def checkout
    @cart = Cart.find(params[:id])
    @cart.cart_checkout
    @cart.user.current_cart = nil
    @cart.user.save
    redirect_to cart_path(@cart)
  end
  
end
