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

  def show
    @cart_products = Product.find(session[:shopping_cart])

    @cart_item_quantities = {}
    @cart_products.each do |product|
      @cart_item_quantities[product.id] = session[:shopping_cart].count(product.id)
    end
  end

  def update
    id = params[:id].to_i
    quantity = params[:quantity].to_i

    # Remove the existing quantity of the product from the cart
    session[:shopping_cart].reject! { |item| item == id }

    # Add the product with the updated quantity to the cart
    quantity.times { session[:shopping_cart] << id }

    redirect_to cart_path, notice: "Quantity updated successfully"
  end

end
