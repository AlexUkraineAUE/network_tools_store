class CheckoutController < ApplicationController
  def create
    user_cart = cart
    total_price = 0
    line_items_array = []

    user_cart.each do |product|
      product_price = product.discounted_price.present? ? product.discounted_price * 100 : product.price * 100
      quantity = params[:product_quantity][product.id.to_s].to_i

      total_price += product_price * quantity

      line_items_array << {
        quantity:,
        price_data: {
          unit_amount:  product_price.to_i,
          currency:     "cad",
          product_data: {
            name:        product.name,
            description: product.description
          }
        }
      }
    end

    pst_amount = total_price * 0.07
    line_items_array << {
      quantity:   1,
      price_data: {
        currency:     "cad",
        unit_amount:  pst_amount.to_i,
        product_data: {
          name:        "PST",
          description: "Provincial Sales Tax"
        }
      }
    }

    gst_amount = total_price * 0.05
    line_items_array << {
      quantity:   1,
      price_data: {
        currency:     "cad",
        unit_amount:  gst_amount.to_i,
        product_data: {
          name:        "GST",
          description: "Goods and Services Tax"
        }
      }
    }

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      mode:                 "payment",
      line_items:           line_items_array
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
    # something went wrong with payment!
  end
end
