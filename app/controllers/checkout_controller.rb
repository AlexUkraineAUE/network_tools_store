class CheckoutController < ApplicationController
  def new
    @cart_products = Product.find(session[:shopping_cart])
    @total_price = calculate_total_price(@cart_products)
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      @order = Order.create(customer_id: @customer.id)
      @cart_products = Product.find(session[:shopping_cart])
      @cart_products.each do |product|
        OrderItem.create(order_id: @order.id, product_id: product.id, quantity: 1, subtotal: product.price)
      end
      session[:shopping_cart] = []
      redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      render :new
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address, :city, :province, :postal_code)
  end

  def calculate_total_price(cart_products)
    total_price = 0
    cart_products.each do |product|
      total_price += product.price
    end
    total_price
  end
end
