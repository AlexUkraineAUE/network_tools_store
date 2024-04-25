class CheckoutController < ApplicationController

  def create
    # establish a connection to Stripe and then redirect the user to the payment screen
    @product = Product.find(params[:product_id])

    if @product.nil?
      redirect_to root_path
      return
    end

    unit_amount = @product.discounted_price.present? ? @product.discounted_price * 100 : @product.price * 100

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      mode: "payment",
      line_items: [
        {
          quantity: 1,
          price_data: {
          unit_amount: unit_amount.to_i,
          currency: "cad",
          product_data: {
            name: @product.name,
            description: @product.description,
          }
        }
        },
        {
          quantity: 1,
            price_data: {
              currency: "cad",
              unit_amount: (unit_amount * 0.05).to_i,
              product_data: {
              name: "GST",
              description: "Goods and Services Tax",
              }
            }
          },
        {
          quantity: 1,
            price_data: {
              currency: "cad",
              unit_amount: (unit_amount * 0.07).to_i,
              product_data: {
              name: "PST",
              description: "Provincial Sales Tax",
              }
            }
          }
      ]
    )

    redirect_to @session.url, allow_other_host: true
    rescue Stripe::StripeError => e
      flash[:error] = e.message
      redirect_to product_path(@product)
  end

  def success
    # we took the customer's money
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # something went wrong with payment!
  end

end
