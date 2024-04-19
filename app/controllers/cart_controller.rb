class CartController < ApplicationController
  def create
    logger.debug("adding #{params[:shopping_cart]} to cart.")
  end

  def destroy

  end

end
