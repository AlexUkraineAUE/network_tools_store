class CartsController < ApplicationController
  def create
    session[:shopping_cart] << params[:product_id]
    redirect_to cart_path, notice: 'Product added to cart successfully.'
  end

  def destroy
    session[:shopping_cart].delete(params[:id])
    redirect_to cart_path, notice: 'Product removed from cart successfully.'
  end
end
