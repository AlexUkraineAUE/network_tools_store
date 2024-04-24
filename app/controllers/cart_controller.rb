class CartController < ApplicationController
  def create
    logger.debug("adding #{params[:shopping_cart]} to cart.")
    id = params[:id].to_i

    session[:shopping_cart] << id unless session[:shopping_cart].include?(id)
    product = Product.find(id)
    flash[:notice] = "+  #{product.name} added to cart."
    redirect_to products_path
  end

  def destroy
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    product = Product.find(id)
    flash[:notice] = "- #{product.name} removed from cart"
    redirect_to products_path
  end

end
